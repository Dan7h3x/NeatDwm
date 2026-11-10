;;; early-init.el --- runs before the first frame  -*- lexical-binding: t; -*-

;; ---------------------------------------------------------------------------
;; Startup speed
;; ---------------------------------------------------------------------------
;; No GC, no file-name handlers and no redisplay while loading; all restored
;; right after startup (see the hook at the bottom).
(defvar my/file-name-handler-alist file-name-handler-alist)

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      file-name-handler-alist nil
      site-run-file nil                 ; skip distro site-start.d scripts
      inhibit-x-resources t
      inhibit-startup-screen t
      inhibit-compacting-font-caches t
      initial-major-mode 'fundamental-mode
      initial-scratch-message nil
      frame-inhibit-implied-resize t
      frame-resize-pixelwise t
      load-prefer-newer nil             ; one stat less per load; packages are compiled on install
      ;; package.el: activate installed packages from ONE precomputed file
      ;; (no scanning of elpa/, no network, no archive refresh at startup).
      package-quickstart t
      package-native-compile t
      native-comp-async-report-warnings-errors 'silent
      native-comp-jit-compilation t)

(setq-default inhibit-redisplay t)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq file-name-handler-alist my/file-name-handler-alist)
            (setq-default inhibit-redisplay nil)
            (redraw-display)))

;; Safety net: if config.el failed before gcmh took over, still get a sane GC.
(add-hook 'emacs-startup-hook
          (lambda ()
            (unless (bound-and-true-p gcmh-mode)
              (setq gc-cons-threshold (* 64 1024 1024)
                    gc-cons-percentage 0.1)))
          90)

;; ---------------------------------------------------------------------------
;; Frame: font, chrome, first-paint colors
;; ---------------------------------------------------------------------------
;; Font here, not in config: no slow `find-font' query and no resize flicker.
;; (A missing font makes Emacs fall back to its default.)
(push '(font . "IoskeleyMonoTerm Nerd Font-16") default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

