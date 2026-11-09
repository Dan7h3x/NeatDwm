;;; init.el --- tangle on demand, load the compiled config  -*- lexical-binding: t; -*-

;; Normal start: load config.elc (native-compiled in the background by Emacs).
;; Nothing is tangled, compiled, installed or downloaded unless something changed.
(let* ((base (expand-file-name "config" user-emacs-directory))
       (org  (concat base ".org"))
       (el   (concat base ".el"))
       (elc  (concat base ".elc")))
  ;; config.org edited outside Emacs? re-tangle (rare; saving inside Emacs does it).
  (when (or (not (file-exists-p el))
            (file-newer-than-file-p org el))
    (require 'ob-tangle)
    (org-babel-tangle-file org el "emacs-lisp")
    ;; tangle skips writing identical output; touch so we do not re-tangle every start
    (set-file-times el))
  (if (and (file-exists-p elc) (not (file-newer-than-file-p el elc)))
      (load base nil 'nomessage)          ; resolves to config.elc
    (load el nil 'nomessage)              ; first run / just changed: slow once...
    (add-hook 'emacs-startup-hook         ; ...then compile for every later start
              (lambda () (run-with-idle-timer 2 nil #'my/compile-config)))))
