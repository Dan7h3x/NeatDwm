;;; -*- lexical-binding: t -*-
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(menu-bar-mode -1)            ; Disable the menu bar
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(setq visible-bell nil) ;; Set up the visible bell

(set-face-attribute 'default nil :family "IoskeleyMonoTerm Nerd Font" :height 175)

(load-theme 'modus-vivendi)
;(load-theme 'tango-dark)

(setq inhibit-startup-message t)

(setq mouse-drag-copy-region t)

(defvar bootstrap-version)
(let ((bootstrap-file
    (expand-file-name
      "straight/repos/straight.el/bootstrap.el"
      (or (bound-and-true-p straight-base-dir)
        user-emacs-directory)))
    (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
       'silent 'inhibit-cookies)
    (goto-char (point-max))
    (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(setq use-package-always-defer t)

(use-package vertico
  :ensure t
  :config
  (vertico-mode 1))

(use-package org
  :ensure nil
  :config
  (set-face-attribute 'org-level-1 nil :height 1.75 :foreground 'unspecified)
  (set-face-attribute 'org-level-2 nil :height 1.25 :foreground 'unspecified)
  (setq org-directory "~/Desktop/MyNotes/")
  (setq org-agenda-files (list org-directory)))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

(use-package savehist
  :ensure nil
  :config
  (savehist-mode 1))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil))

(use-package delsel
  :ensure nil
  :config
  (delete-selection-mode 1))

(use-package evil
    :demand
    :config
    (evil-mode 1))

(use-package emacs
  :init
  (defalias 'yes-or-no-p 'y-or-n-p)
)
(use-package emacs
  :init
  (set-charset-priority 'unicode)
  (setq locale-coding-system 'utf-8
        coding-system-for-read 'utf-8
        coding-system-for-write 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (setq default-process-coding-system '(utf-8-unix . utf-8-unix)))


;;; Bidi
;;; input/bidi/config.el -*- lexical-binding: t; -*-

(defvar +bidi-hebrew-font (font-spec :family "DejaVu Sans")
  "Overriding font for hebrew script.
Must be a `font-spec', see `doom-font' for examples.

WARNING: if you specify a size for this font it will hard-lock any usage of this
font to that size. It's rarely a good idea to do so! Set
`+bidi-hebrew-font-scale' to scale the font up or down.")

(defcustom +bidi-hebrew-font-scale 1.0
  "What scale to display `+bidi-hebrew-font' at."
  :type 'float)

(defface +bidi-hebrew-face `((t :font ,+bidi-hebrew-font)) "")

(defvar +bidi-arabic-font (font-spec :family "Sahel")
  "Overriding font for arabic and arabic-derived scripts.
Must be a `font-spec', see `doom-font' for examples.

WARNING: if you specify a size for this font it will hard-lock any usage of this
font to that size. It's rarely a good idea to do so! Set
`+bidi-arabic-font-scale' to scale the font up or down.")

(defcustom +bidi-arabic-font-scale 1.0
  "What scale to display `+bidi-arabic-font' at."
  :type 'float)

(defface +bidi-arabic-face `((t :font ,+bidi-arabic-font)) "")

(defcustom +bidi-want-smart-fontify t
  "Use bidi override fonts on surrounding space and punctuation as well.
Add `+bidi-smart-fontify-keywords' to `font-lock-keywords' on editable buffers
when `+bidi-mode' is on."
  :type 'boolean)

(defvar +bidi-smart-fontify-keywords
  `((,(rx (any (#x0590 . #x05FF))       ; Hebrew
          (group (one-or-more (any " " punctuation))))
     (1 '+bidi-hebrew-face t))
    (,(rx (or (any (#x0600 . #x06FF))   ; Arabic
              (any (#x0750 . #x077F))   ; Arabic Supplement
              (any (#x0870 . #x089F))   ; Arabic Extended-B
              (any (#x08A0 . #x08FF)))  ; Arabic Extended-A
          (group (one-or-more (any " " punctuation))))
     (1 '+bidi-arabic-face t)))

  "`font-lock' keywords matching spaces and punctuation after RTL characters.
See the variable `font-lock-keywords' for information on the format.")

(defcustom +bidi-paragraph-direction nil
  "The value of `bidi-paragragh-direction' when `+bidi-mode' is on.
See the `bidi-paragraph-direction' for more info.

Warning: do not change this if you are using `+bidi-global-mode'.'"
  :type '(choice
          (const :tag "Left to Right" left-to-right)
          (const :tag "Right to Left" right-to-left)
          (const :tag "Dynamic, according to paragraph text" nil)))


(defvar +bidi-mode-map (make-sparse-keymap)
  "Keymap for `+bidi-mode'.")

(define-minor-mode +bidi-mode
  "Minor mode for using bidirectional text in a buffer.

Note that the whole buffer doesn't have to contain any
bidirectional text at all, this mode just makes bidi editing
easier."
  :keymap +bidi-mode-map
  (if +bidi-mode
      (progn
        (setq bidi-paragraph-direction +bidi-paragraph-direction   ; Better paragraph alignment
              bidi-paragraph-separate-re "^" ; No need for empty lines to switch alignment
              bidi-paragraph-start-re "^"    ; ^
              bidi-inhibit-bpa nil)          ; Better bidi paren logic
        (when (and +bidi-want-smart-fontify
                   (not buffer-read-only))
          (font-lock-add-keywords
           nil
           +bidi-smart-fontify-keywords
           'append)
          (font-lock-flush)))
    (setq bidi-paragraph-direction 'left-to-right
          bidi-paragraph-separate-re nil
          bidi-paragraph-start-re nil
          bidi-inhibit-bpa t)
    (when (and +bidi-want-smart-fontify
               (not buffer-read-only))
      (font-lock-remove-keywords
       nil
       +bidi-smart-fontify-keywords)
      (font-lock-flush))))

(define-globalized-minor-mode +bidi-global-mode +bidi-mode +bidi-mode)


(defun +bidi--set-font (name)
  (when-let* ((font-name (format "+bidi-%s-font" name))
              (font-var (or (intern-soft font-name) (error "Invalid font: %s" name)))
              (font (symbol-value font-var)))
    (condition-case e
        (let ((scale (symbol-value (intern (format "+bidi-%s-font-scale" name)))))
          (set-fontset-font t name font)
          (set-face-font (intern (format "+bidi-%s-face" name)) font)
          (when (/= scale 1.0)
            (setf (alist-get (symbol-name (font-get font :family)) face-font-rescale-alist nil nil #'equal)
                  scale)))
      ('error
       (if (string-prefix-p "Font not available" (error-message-string e))
           (warn "Missing font for `%s': %s" font-name (font-get font :family))
         (signal (car e) (cdr e)))))))

(defun +bidi-init-fonts-h ()
  (if (not (fboundp 'set-fontset-font))
      (warn "`set-fontset-font' is missing. Emacs may be missing font support.")
    (+bidi--set-font 'hebrew)
    (+bidi--set-font 'arabic)))

(add-hook 'after-setting-font-hook #'+bidi-init-fonts-h)
