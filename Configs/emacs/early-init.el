;;; early-init.el --- runs before the first frame  -*- lexical-binding: t; -*-

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
      load-prefer-newer nil
      package-quickstart nil
      package-native-compile t
      native-comp-async-report-warnings-errors 'silent
      native-comp-jit-compilation t)

(setq byte-compile-warnings '(not byte-compile-free-vars-warn))

(setq-default inhibit-redisplay t)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq file-name-handler-alist my/file-name-handler-alist)
            (setq-default inhibit-redisplay nil)
            (redraw-display)))


(push '(font . "IoskeleyMonoTerm Nerd Font-16") default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
