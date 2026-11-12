;;; pywal-modus.el --- Drive the Modus themes from pywal colours -*- lexical-binding: t; -*-

;; Version: 1.1
;; Package-Requires: ((emacs "27.1") (modus-themes "4.0"))
;; Keywords: faces

;;; Commentary:

;; Keeps Protesilaos's Modus themes (all their package coverage, accessibility
;; work and design) and feeds them a palette derived from pywal's colors.json.
;;
;;   (with-demoted-errors "pywal-modus: %S"
;;     (load (expand-file-name "pywal-modus.el" user-emacs-directory) nil t)
;;     (pywal-modus-mode 1))
;;
;; What it does
;;   - picks `modus-vivendi' for a dark pywal palette and `modus-operandi'
;;     for a light one (`wal -l'), judged by the luminance of pywal's background;
;;   - generates every literal colour of the Modus palette from pywal: neutrals,
;;     six accents with their warmer/cooler/faint/intense variants, background
;;     tints, mode line, region, diff, tabs, ...  Mappings (keyword, string,
;;     headings, Org, magit, ...) are left to Modus and follow automatically;
;;   - guarantees a minimum WCAG contrast for every accent, keeping its hue;
;;   - optionally makes ansi-color/term/vterm/eat use pywal's exact 16 colours;
;;   - follows `wal' live (cheap mtime poll, robust against half-written files).
;;
;; Requires modus-themes 4.0 or newer: bundled with Emacs 30+, or install from
;; GNU ELPA with M-x package-install RET modus-themes (Emacs 29 ships 3.0,
;; which has no palette overrides).
;;
;; Commands: `pywal-modus-mode', `pywal-modus-reload', `pywal-modus-doctor'.

;;; Code:

(require 'color)
(require 'cl-lib)

(declare-function modus-themes-load-theme "modus-themes")
(declare-function json-read-file "json")
(defvar modus-themes-common-palette-overrides)

;;;; Options

(defgroup pywal-modus nil
  "Drive the Modus themes from pywal."
  :group 'faces
  :prefix "pywal-modus-")

(defcustom pywal-modus-colors-file
  (expand-file-name "wal/colors.json" (or (getenv "XDG_CACHE_HOME") "~/.cache"))
  "Path to the colors.json written by pywal."
  :type 'file)

(defcustom pywal-modus-dark-theme 'modus-vivendi
  "Modus theme used when pywal's palette is dark."
  :type '(choice (const modus-vivendi) (const modus-vivendi-tinted)
                 (const modus-vivendi-deuteranopia) (const modus-vivendi-tritanopia)
                 symbol))

(defcustom pywal-modus-light-theme 'modus-operandi
  "Modus theme used when pywal's palette is light."
  :type '(choice (const modus-operandi) (const modus-operandi-tinted)
                 (const modus-operandi-deuteranopia) (const modus-operandi-tritanopia)
                 symbol))

(defcustom pywal-modus-accent 'color4
  "Key in colors.json used for region, mode line and completion tints."
  :type 'symbol)

(defcustom pywal-modus-min-contrast 6.0
  "Minimum WCAG contrast ratio between accent colours and the background.
Modus itself targets 7:1; lower values keep more of pywal's colour."
  :type 'number)

(defcustom pywal-modus-exact-terminal-colors t
  "When non-nil, ansi-color/term/vterm/eat use pywal's raw 16 colours."
  :type 'boolean)

(defcustom pywal-modus-colored-headings t
  "When non-nil, give Org/outline/Markdown headings different accent colours.
Modus leaves them in the plain foreground colour by default."
  :type 'boolean)

(defcustom pywal-modus-extra-overrides nil
  "Your own Modus palette overrides; they win over the pywal-derived ones.
Same format as `modus-themes-common-palette-overrides', for example
\\='((cursor red-intense) (bg-region \"#334455\")), or a Modus preset such as
`modus-themes-preset-overrides-faint'."
  :type '(repeat (list symbol (choice symbol string))))

(defcustom pywal-modus-poll-interval 1.0
  "Seconds between checks of `pywal-modus-colors-file' while the mode is on."
  :type 'number)

(defcustom pywal-modus-after-reload-hook nil
  "Hook run after `pywal-modus-reload' has applied a new palette."
  :type 'hook)

(defconst pywal-modus--fallback
  '((special (background . "#16181f") (foreground . "#d5d8e0") (cursor . "#d5d8e0"))
    (colors (color0 . "#16181f") (color1 . "#e0626a") (color2 . "#8fbf6f")
            (color3 . "#dcb467") (color4 . "#6aa2e0") (color5 . "#b585d6")
            (color6 . "#5fbfc0") (color7 . "#d5d8e0") (color8 . "#4a4f60")
            (color9 . "#ee7d84") (color10 . "#a6d488") (color11 . "#ecc983")
            (color12 . "#86b6ee") (color13 . "#c9a0e6") (color14 . "#7dd0d1")
            (color15 . "#f0f2f7")))
  "Palette used for anything missing from `pywal-modus-colors-file'.")

;;;; Colour maths (hex is parsed directly: `color-name-to-rgb' quantises on
;;;; limited-colour terminals and in display-less daemons)

(defun pywal-modus--rgb (c)
  "Return colour C as (R G B) floats in 0..1."
  (cond
   ((and (stringp c)
         (string-match
          "\\`#\\([0-9a-fA-F]\\{2\\}\\)\\([0-9a-fA-F]\\{2\\}\\)\\([0-9a-fA-F]\\{2\\}\\)\\'" c))
    (mapcar (lambda (i) (/ (string-to-number (match-string i c) 16) 255.0))
            '(1 2 3)))
   (t (or (and (stringp c) (color-name-to-rgb c)) '(0.5 0.5 0.5)))))

(defun pywal-modus--hex (rgb)
  "Return the (R G B) list RGB as #rrggbb."
  (apply #'color-rgb-to-hex (append rgb '(2))))

(defun pywal-modus--mix (a b ratio)
  "Return colour A moved toward colour B by RATIO (0..1)."
  (pywal-modus--hex
   (cl-mapcar (lambda (x y) (+ (* x (- 1 ratio)) (* y ratio)))
              (pywal-modus--rgb a) (pywal-modus--rgb b))))

(defun pywal-modus--lum (c)
  "WCAG relative luminance of colour C."
  (let ((l (mapcar (lambda (v)
                     (if (<= v 0.03928) (/ v 12.92) (expt (/ (+ v 0.055) 1.055) 2.4)))
                   (pywal-modus--rgb c))))
    (+ (* 0.2126 (nth 0 l)) (* 0.7152 (nth 1 l)) (* 0.0722 (nth 2 l)))))

(defun pywal-modus--contrast (a b)
  "WCAG contrast ratio between colours A and B."
  (let ((x (pywal-modus--lum a)) (y (pywal-modus--lum b)))
    (/ (+ (max x y) 0.05) (+ (min x y) 0.05))))

(defun pywal-modus--ensure (c bg fg ratio)
  "Make colour C reach contrast RATIO against BG, keeping its hue.
Lightness moves away from BG in HSL space; as a last resort C is blended
toward FG."
  (let* ((hsl (apply #'color-rgb-to-hsl (pywal-modus--rgb c)))
         (h (nth 0 hsl)) (s (nth 1 hsl)) (l (nth 2 hsl))
         (step (if (> (pywal-modus--lum fg) (pywal-modus--lum bg)) 0.02 -0.02))
         (i 0))
    (while (and (< (pywal-modus--contrast c bg) ratio) (< i 50))
      (setq l (min 1.0 (max 0.0 (+ l step)))
            c (pywal-modus--hex (color-hsl-to-rgb h s l))
            i (1+ i)))
    (setq i 0)
    (while (and (< (pywal-modus--contrast c bg) ratio) (< i 25))
      (setq c (pywal-modus--mix c fg 0.08)
            i (1+ i)))
    c))

(defun pywal-modus--saturate (c delta)
  "Return colour C with its HSL saturation changed by DELTA."
  (pcase-let ((`(,h ,s ,l) (apply #'color-rgb-to-hsl (pywal-modus--rgb c))))
    (pywal-modus--hex (color-hsl-to-rgb h (min 1.0 (max 0.0 (+ s delta))) l))))

(defun pywal-modus--shift (c delta)
  "Return colour C with its hue rotated by DELTA (fraction of the wheel)."
  (pcase-let ((`(,h ,s ,l) (apply #'color-rgb-to-hsl (pywal-modus--rgb c))))
    (let ((nh (+ h delta)))
      (pywal-modus--hex (color-hsl-to-rgb (- nh (floor nh)) s l)))))

(defun pywal-modus--warm-sign (c)
  "Return 1 or -1: the direction that rotates C's hue toward orange.
Matches Modus: blue-warmer leans purple, green-warmer leans yellow."
  (let* ((h (car (apply #'color-rgb-to-hsl (pywal-modus--rgb c))))
         (d (- 0.05 h)))
    (if (>= (- d (round d)) 0) 1 -1)))

(defun pywal-modus--tint (bg col fg ratio min)
  "Mix COL into BG by RATIO, shrinking RATIO until FG has contrast MIN on it."
  (let ((out (pywal-modus--mix bg col ratio)) (i 0))
    (while (and (< (pywal-modus--contrast fg out) min) (< i 25))
      (setq ratio (* ratio 0.85)
            out (pywal-modus--mix bg col ratio)
            i (1+ i)))
    out))

(defun pywal-modus--pick-hue (cands target)
  "Return the colour in CANDS nearest hue TARGET (0..1), or nil.
Only reasonably saturated colours within about 25 degrees qualify."
  (let (best (best-d 1.0))
    (dolist (c cands)
      (pcase-let ((`(,h ,s ,_) (apply #'color-rgb-to-hsl (pywal-modus--rgb c))))
        (let ((d (min (abs (- h target)) (- 1 (abs (- h target))))))
          (when (and (> s 0.2) (< d best-d))
            (setq best c best-d d)))))
    (and best (< best-d 0.07) best)))

;;;; Reading pywal

(defvar pywal-modus--last-good nil
  "Last successfully parsed colors.json, kept in case a later read is torn.")

(defun pywal-modus--read ()
  "Return pywal's colors.json as an alist, or nil if the file is missing.
If the file exists but cannot be parsed (e.g. `wal' is mid-write) the last
good palette is returned instead."
  (when (file-readable-p pywal-modus-colors-file)
    (condition-case err
        (setq pywal-modus--last-good
              (if (fboundp 'json-parse-file)
                  (json-parse-file pywal-modus-colors-file :object-type 'alist)
                (require 'json)
                (json-read-file pywal-modus-colors-file)))
      (error (message "pywal-modus: cannot parse %s (%s)"
                      pywal-modus-colors-file (error-message-string err))
             pywal-modus--last-good))))

;;;; Palette generation

(defun pywal-modus--build ()
  "Return a plist (:theme :dark :bg :fg :accents :overrides) from pywal."
  (let* ((raw (pywal-modus--read))
         (get (lambda (section key)
                (or (alist-get key (alist-get section raw))
                    (alist-get key (alist-get section pywal-modus--fallback)))))
         (bg (funcall get 'special 'background))
         (fg (funcall get 'special 'foreground))
         (dark (< (pywal-modus--lum bg) 0.179))
         (ratio pywal-modus-min-contrast)
         (raw-n (lambda (n) (funcall get 'colors (intern (format "color%d" n)))))
         (adj-n (lambda (n) (pywal-modus--ensure (funcall raw-n n) bg fg ratio)))
         (cands (mapcar adj-n '(1 2 3 4 5 6 9 10 11 12 13 14)))
         (sem (lambda (hue fallback)
                (pywal-modus--ensure (or (pywal-modus--pick-hue cands hue) fallback)
                                     bg fg ratio)))
         ;; red/yellow/green are semantic (errors, warnings, success) so they
         ;; are matched by hue; blue/magenta/cyan keep pywal's own colours.
         (red (funcall sem 0.0 "#d0505a"))
         (yellow (funcall sem 0.12 "#c9a050"))
         (green (funcall sem 0.33 "#6fa95a"))
         (blue (funcall adj-n 4))
         (magenta (funcall adj-n 5))
         (cyan (funcall adj-n 6))
         (accent (pywal-modus--ensure
                  (or (funcall get 'colors pywal-modus-accent) (funcall raw-n 4))
                  bg fg ratio))
         (mid (pywal-modus--mix bg fg 0.5))
         (hues `((red . ,red) (green . ,green) (yellow . ,yellow)
                 (blue . ,blue) (magenta . ,magenta) (cyan . ,cyan)))
         out)
    (cl-labels
        ((add (key val) (push (list key val) out))
         (mixc (a b r) (pywal-modus--mix a b r))
         (ens (c on r) (pywal-modus--ensure c on fg r))
         (tint (col r min) (pywal-modus--tint bg col fg r min)))
      ;; --- Neutrals ------------------------------------------------------
      (add 'bg-main bg)
      (add 'bg-dim (mixc bg fg 0.06))
      (add 'fg-main fg)
      (add 'fg-dim (ens (mixc fg bg 0.35) bg 4.5))
      (add 'fg-alt (ens (mixc fg accent 0.30) bg 5.0))
      (add 'bg-active (mixc bg fg 0.22))
      (add 'bg-inactive (mixc bg fg 0.12))
      (add 'border (mixc bg fg 0.32))
      ;; --- Accents and their variants -----------------------------------
      (dolist (h hues)
        (let* ((n (symbol-name (car h))) (c (cdr h)))
          (add (car h) c)
          (let ((d (* 0.045 (pywal-modus--warm-sign c))))
            (add (intern (concat n "-warmer")) (ens (pywal-modus--shift c d) bg ratio))
            (add (intern (concat n "-cooler")) (ens (pywal-modus--shift c (- d)) bg ratio)))
          (add (intern (concat n "-faint")) (ens (mixc c mid 0.45) bg ratio))
          (add (intern (concat n "-intense"))
               (ens (pywal-modus--saturate c 0.2) bg (+ ratio 1.0)))
          ;; background tints
          (add (intern (format "bg-%s-intense" n)) (tint c (if dark 0.42 0.45) 4.5))
          (add (intern (format "bg-%s-subtle" n)) (tint c (if dark 0.26 0.20) 7.0))
          (add (intern (format "bg-%s-nuanced" n)) (tint c (if dark 0.10 0.08) 7.0))
          (add (intern (format "bg-graph-%s-0" n)) (tint c 0.50 3.0))
          (add (intern (format "bg-graph-%s-1" n)) (tint c 0.30 4.5))))
      ;; --- Extra named colours ------------------------------------------
      (add 'rust (ens (mixc red yellow 0.35) bg ratio))
      (add 'gold (ens (mixc yellow fg 0.15) bg ratio))
      (add 'olive (ens (mixc green yellow 0.40) bg ratio))
      (add 'slate (ens (mixc blue mid 0.50) bg ratio))
      (add 'indigo (ens (mixc blue magenta 0.50) bg ratio))
      (add 'maroon (ens (mixc red magenta 0.30) bg ratio))
      (add 'pink (ens (mixc magenta fg 0.30) bg ratio))
      (dolist (spec `((clay . ,(mixc red yellow 0.5)) (ochre . ,yellow)
                      (lavender . ,(mixc blue magenta 0.5)) (sage . ,(mixc green cyan 0.5))))
        (let ((bgc (tint (cdr spec) 0.25 7.0)))
          (add (intern (format "bg-%s" (car spec))) bgc)
          (add (intern (format "fg-%s" (car spec))) (ens (cdr spec) bgc 6.0))))
      ;; --- Surfaces -----------------------------------------------------
      (let* ((ml (tint blue (if dark 0.34 0.22) 7.0))
             (ml-in (mixc bg fg 0.10)))
        (add 'bg-region (tint accent (if dark 0.32 0.26) 7.0))
        (add 'bg-hl-line (tint accent 0.12 9.0))
        (add 'bg-completion (tint accent 0.28 7.0))
        (add 'bg-popup (mixc bg fg 0.06))
        (add 'bg-hover (tint cyan 0.30 7.0))
        (add 'bg-hover-secondary (tint yellow 0.30 7.0))
        (add 'bg-mode-line-active ml)
        (add 'border-mode-line-active (mixc ml fg 0.25))
        (add 'bg-mode-line-inactive ml-in)
        (add 'fg-mode-line-inactive (ens (mixc fg bg 0.35) ml-in 4.5))
        (add 'border-mode-line-inactive (mixc bg fg 0.18))
        (add 'modeline-err (ens red ml 4.5))
        (add 'modeline-warning (ens yellow ml 4.5))
        (add 'modeline-info (ens cyan ml 4.5))
        (add 'bg-tab-bar (mixc bg fg 0.08))
        (add 'bg-tab-current bg)
        (add 'bg-tab-other (mixc bg fg 0.18))
        (add 'bg-diff-context (mixc bg fg 0.05))
        (add 'bg-paren-match (tint cyan 0.38 7.0))
        (add 'bg-paren-expression (tint magenta 0.20 7.0)))
      ;; --- Diff ---------------------------------------------------------
      (dolist (spec `((added . ,green) (changed . ,yellow) (removed . ,red)))
        (let* ((n (symbol-name (car spec))) (c (cdr spec))
               (bgx (tint c (if dark 0.22 0.18) 7.0))
               (refine (tint c 0.38 5.0)))
          (add (intern (format "bg-%s" n)) bgx)
          (add (intern (format "bg-%s-faint" n)) (tint c 0.10 7.0))
          (add (intern (format "bg-%s-refine" n)) refine)
          (add (intern (format "bg-%s-fringe" n)) (mixc bg c 0.75))
          (add (intern (format "fg-%s" n)) (ens c bgx 6.0))
          (add (intern (format "fg-%s-intense" n))
               (ens (pywal-modus--saturate c 0.2) refine 5.0))))
      ;; --- Headings (mappings to the accents generated above) -----------
      (when pywal-modus-colored-headings
        (cl-loop for i from 0
                 for sym in '(cyan-cooler blue-warmer magenta-cooler cyan-cooler
                              yellow-cooler green-warmer red-cooler blue-cooler
                              magenta-warmer)
                 do (add (intern (format "fg-heading-%d" i)) sym)))
      ;; --- Terminal colours: pywal's exact 16 ---------------------------
      (when pywal-modus-exact-terminal-colors
        (let ((names '("black" "red" "green" "yellow" "blue" "magenta" "cyan" "white")))
          (dotimes (i 16)
            (let ((name (concat (nth (% i 8) names) (if (> i 7) "-bright" "")))
                  (col (funcall raw-n i)))
              (add (intern (concat "bg-term-" name)) col)
              (add (intern (concat "fg-term-" name)) col))))))
    (list :theme (if dark pywal-modus-dark-theme pywal-modus-light-theme)
          :dark dark :bg bg :fg fg
          :accents (append `((accent . ,accent)) hues)
          :overrides (nreverse out))))

;;;; Applying

(defvar pywal-modus--user-common nil
  "The user's own `modus-themes-common-palette-overrides', saved on first use.")
(defvar pywal-modus--ours :none
  "The value we last stored in `modus-themes-common-palette-overrides'.")
(defvar pywal-modus--timer nil)
(defvar pywal-modus--applied nil "Modification time of colors.json last applied.")
(defvar pywal-modus--seen nil "Modification time seen on the previous poll.")

(defun pywal-modus--require ()
  "Load modus-themes 4.0+ or signal a helpful error."
  (unless (require 'modus-themes nil t)
    (user-error "pywal-modus: modus-themes not found.  Use Emacs 30+, or M-x package-install RET modus-themes (Emacs 29 bundles only 3.0)"))
  (unless (boundp 'modus-themes-common-palette-overrides)
    (user-error "pywal-modus: your modus-themes is too old (need 4.0+); install it from GNU ELPA")))

(defun pywal-modus--stamp ()
  "Modification time of `pywal-modus-colors-file', or nil if it is missing."
  (file-attribute-modification-time (file-attributes pywal-modus-colors-file)))

;; FIX: `equal' on time objects is fragile; use `time-equal-p' (Emacs 27+).
(defun pywal-modus--same-stamp (a b)
  "Non-nil when timestamps A and B denote the same instant."
  (and a b (time-equal-p a b)))

;;;###autoload
(defun pywal-modus-reload ()
  "Re-read pywal's colours and re-apply the matching Modus theme."
  (interactive)
  (pywal-modus--require)
  (let* ((built (pywal-modus--build))
         (theme (plist-get built :theme)))
    ;; Preserve whatever overrides the user had before we first took over.
    (unless (eq modus-themes-common-palette-overrides pywal-modus--ours)
      (setq pywal-modus--user-common modus-themes-common-palette-overrides))
    ;; First match wins: extra > user's own > pywal-derived.
    (setq pywal-modus--ours (append pywal-modus-extra-overrides
                                    pywal-modus--user-common
                                    (plist-get built :overrides))
          modus-themes-common-palette-overrides pywal-modus--ours)
    (if (fboundp 'modus-themes-load-theme)
        (modus-themes-load-theme theme)
      (mapc #'disable-theme custom-enabled-themes)
      (load-theme theme t))
    (setq pywal-modus--applied (pywal-modus--stamp))
    (run-hooks 'pywal-modus-after-reload-hook)
    theme))

(defun pywal-modus--poll ()
  "Reload once colors.json has changed and then stayed unchanged for a poll.
Waiting one extra poll avoids reading a file `wal' is still writing."
  (let ((now (pywal-modus--stamp)))
    (cond ((or (null now) (pywal-modus--same-stamp now pywal-modus--applied))
           (setq pywal-modus--seen now))
          ((pywal-modus--same-stamp now pywal-modus--seen)
           (setq pywal-modus--applied now)
           (condition-case err (pywal-modus-reload)
             (error (message "pywal-modus: reload failed: %s" (error-message-string err)))))
          (t (setq pywal-modus--seen now)))))

;;;###autoload
(define-minor-mode pywal-modus-mode
  "Apply Modus themes from pywal's colours and follow `wal' changes live."
  :global t
  :group 'pywal-modus
  (when (timerp pywal-modus--timer)
    (cancel-timer pywal-modus--timer)
    (setq pywal-modus--timer nil))
  (when pywal-modus-mode
    (condition-case err
        (progn
          (pywal-modus-reload)
          (setq pywal-modus--seen pywal-modus--applied
                pywal-modus--timer
                (run-with-timer pywal-modus-poll-interval
                                pywal-modus-poll-interval #'pywal-modus--poll)))
      ;; FIX: let define-minor-mode reset the variable itself.
      (error (pywal-modus-mode -1)
             (signal (car err) (cdr err))))))

;;;###autoload
(defun pywal-modus-doctor ()
  "Show what pywal-modus sees: file, mode, chosen theme and contrast ratios."
  (interactive)
  (let* ((b (pywal-modus--build))
         (bg (plist-get b :bg))
         (found (file-readable-p pywal-modus-colors-file)))
    (with-current-buffer (get-buffer-create "*pywal-modus-doctor*")
      (let ((inhibit-read-only t))
        (erase-buffer)
        (insert (format "colors file   : %s  [%s]\n" pywal-modus-colors-file
                        (if found "found" "MISSING - using built-in fallback palette")))
        (insert (format "palette mode  : %s  ->  %s\n"
                        (if (plist-get b :dark) "dark" "light") (plist-get b :theme)))
        (insert (format "modus-themes  : %s\n"
                        (or (locate-library "modus-themes") "NOT FOUND (need 4.0+)")))
        (insert (format "overrides     : %d derived, %d extra\n"
                        (length (plist-get b :overrides))
                        (length pywal-modus-extra-overrides)))
        (insert (format "theme enabled : %s\n"
                        (if (memq (plist-get b :theme) custom-enabled-themes) "yes" "no")))
        (insert (format "auto-reload   : %s\n\n"
                        (if pywal-modus--timer
                            (format "on (every %.1fs)" pywal-modus-poll-interval) "off")))
        (dolist (k (append '(bg-main fg-main fg-dim) (mapcar #'car (plist-get b :accents))))
          (let ((c (or (alist-get k (plist-get b :accents))
                       (cadr (assq k (plist-get b :overrides))))))
            (insert (format "%-8s %s  " k c)
                    (propertize "  Sample text  " 'face `(:foreground ,c :background ,bg))
                    (format "  %.2f:1\n" (pywal-modus--contrast c bg))))))
      (special-mode)
      (goto-char (point-min))
      (pop-to-buffer (current-buffer)))))

(provide 'pywal-modus)
;;; pywal-modus.el ends here
