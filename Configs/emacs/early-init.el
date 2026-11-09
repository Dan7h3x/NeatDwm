;;; early-init.el --- runs before the first frame  -*- lexical-binding: t; -*-

;; Startup speed: no GC and no file-name handlers while loading.
(defvar my/file-name-handler-alist file-name-handler-alist)
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      file-name-handler-alist nil
      load-prefer-newer t
      frame-inhibit-implied-resize t
      inhibit-compacting-font-caches t
      inhibit-startup-screen t
      native-comp-async-report-warnings-errors 'silent
      native-comp-deferred-compilation t)

(add-hook 'emacs-startup-hook
          (lambda () (setq file-name-handler-alist my/file-name-handler-alist)))

;; No chrome.
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Avoid the white flash: paint the first frame with pywal's colors.
(setq use-package-always-ensure nil
      use-package-expand-minimally t
      use-package-compute-statistics nil)


(add-hook 'emacs-startup-hook
          (lambda ()
            (run-with-idle-timer 0.5 nil
                                 (lambda ()
                                   (recentf-mode 1)
                                   (save-place-mode 1)
                                   (savehist-mode 1)))))

(setq package-quickstart t)
