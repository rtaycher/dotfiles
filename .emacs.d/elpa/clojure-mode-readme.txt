;;; Commentary:

;; Provides font-lock, indentation, and navigation for the Clojure
;; language. (http://clojure.org)

;;; Installation:

;; If you use ELPA (http://tromey.com/elpa), you can install via the
;; M-x package-list-packages interface. This is preferrable as you
;; will have access to updates automatically.

;; If you need to install by hand for some reason:

;; (0) Add this file to your load-path, usually the ~/.emacs.d directory.
;; (1) Either:
;;     Add this to your .emacs config: (require 'clojure-mode)
;;     Or generate autoloads with the `update-directory-autoloads' function.

;; See also the swank-clojure package for better interaction with
;; Clojure subprocesses. Note that M-x clojure-install functionality
;; has been moved to that package and is deprecated here.

;; Users of older Emacs (pre-22) should get version 1.4:
;; http://github.com/technomancy/clojure-mode/tree/1.4

;; Paredit users:

;; Download paredit v21 or greater
;;    http://mumble.net/~campbell/emacs/paredit.el

;; Use paredit as you normally would with any other mode; for instance:
;;
;;   ;; require or autoload paredit-mode
;;   (defun lisp-enable-paredit-hook () (paredit-mode 1))
;;   (add-hook 'clojure-mode-hook 'lisp-enable-paredit-hook)

