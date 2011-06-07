;;; Commentary:

;; This library depends on GNU find.

;; This file provides a method for quickly finding any file in a given
;; project. Projects are defined as per the `project-local-variables'
;; library, by the presence of a `.emacs-project' file in a directory.

;; By default, it looks only for files whose names match
;; `ffip-regexp', but it's understood that that variable will be
;; overridden locally. This can be done either with a mode hook:

;; (add-hook 'emacs-lisp-mode-hook (lambda (setl ffip-regexp ".*\\.el")))

;; or by setting it in your .emacs-project file, in which case it will
;; get set locally by the project-local-variables library.

;; You can also be a bit more specific about what files you want to
;; find. For instance, in a Ruby on Rails project, you may be
;; interested in all .rb files that don't exist in the "vendor"
;; directory. In that case you could locally set `ffip-find-options'
;; to "" from within a hook or your .emacs-project file. The options
;; accepted in that variable are passed directly to the Unix `find'
;; command, so any valid arguments for that program are acceptable.

;; If `ido-mode' is enabled, the menu will use `ido-completing-read'
;; instead of `completing-read'.

;; Recommended binding:
;; (global-set-key (kbd "C-x C-M-f") 'find-file-in-project)

