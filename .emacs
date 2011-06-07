;; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.


;;System Clipboard integration from
(setq x-select-enable-clipboard t)

;;Package locations from http://sachachua.com/blog/2011/01/emacs-24-package-manager/
;; Add the original Emacs Lisp Package Archive
                                        ;(add-to-list 'package-archives
                                        ;             '("elpa" . "http://tromey.com/elpa/"))
;; Add the user-contributed repository
                                        ;(add-to-list 'package-archives
                                        ;             '("marmalade" . "http://marmalade-repo.org/packages/")

                                        ;http://www.viget.com/extend/emacs-24-rails-development-environment-from-scratch-to-productive-in-5-minu/

(require 'package)
(setq package-archives (cons '("tromey" . "http://tromey.com/elpa/") package-archives))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)

                                        ;add to path
(push "/usr/local/bin" exec-path)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq inhibit-startup-message t)

(fset 'yes-or-no-p 'y-or-n-p)

(delete-selection-mode t)
(scroll-bar-mode -1)
                                        ;(tool-bar-mode -1)
(blink-cursor-mode t)
(show-paren-mode t)
(column-number-mode t)
(set-fringe-style -1)
(tooltip-mode -1)

(global-set-key "\M- " 'hippie-expand)

(load-theme 'tango-dark)

                                        ;mode hooks
(defun ruby-mode-hook ()
  (autoload 'ruby-mode "ruby-mode" nil t)
  (add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
  (add-hook 'ruby-mode-hook '(lambda ()
                               (setq ruby-deep-arglist t)
                               (setq ruby-deep-indent-paren nil)
                               (setq c-tab-always-indent nil)
                               (require 'inf-ruby)
                               (require 'ruby-compilation))))
(defun rhtml-mode-hook ()
  (autoload 'rhtml-mode "rhtml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
  (add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))
  (add-hook 'rhtml-mode '(lambda ()
                           (define-key rhtml-mode-map (kbd "M-s") 'save-buffer))))

(defun yaml-mode-hook ()
  (autoload 'yaml-mode "yaml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))

(defun css-mode-hook ()
  (autoload 'css-mode "css-mode" nil t)
  (add-hook 'css-mode-hook '(lambda ()
                              (setq css-indent-level 2)
                              (setq css-indent-offset 2))))

(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)

(setq el-get-sources
      '((:name ruby-mode 
               :type elpa
               :load "ruby-mode.el"
               :after (lambda () (ruby-mode-hook)))
        (:name inf-ruby  :type elpa)
        (:name ruby-compilation :type elpa)
        (:name css-mode 
               :type elpa 
               :after (lambda () (css-mode-hook)))
        (:name textmate
               :type git
               :url "git://github.com/defunkt/textmate.el"
               :load "textmate.el")
        (:name rvm
               :type git
               :url "http://github.com/djwhitt/rvm.el.git"
               :load "rvm.el"
               :compile ("rvm.el")
               :after (lambda() (rvm-use-default)))
        (:name rhtml
               :type git
               :url "https://github.com/eschulte/rhtml.git"
               :features rhtml-mode
               :after (lambda () (rhtml-mode-hook)))
        (:name yaml-mode 
               :type git
               :url "http://github.com/yoshiki/yaml-mode.git"
               :features yaml-mode
               :after (lambda () (yaml-mode-hook)))))
       (:name anything
              :type git
              :url "http://repo.or.cz/r/anything-config.git"
              :load-path ("." "extensions")
              :features anything)
       (:name color-theme-zenburn :type git :url "https://github.com/emacsmirror/zenburn.git")
       (:name csharp-mode
              :type git
              :url "http://csharpmode.googlecode.com/svn/trunk/"
              :features csharp-mode)
       (:name full-ack
              :type git
              :url "https://github.com/nschum/full-ack.git"
              :post-init (lambda ()
                    (autoload 'ack "full-ack" nil t)
                    (autoload 'ack-find-file "full-ack" nil t)
                    (autoload 'ack-find-same-file "full-ack" nil t)
                    (autoload 'ack-same "full-ack" nil t)))

       (:name cedet
              :type bzr
              :url "bzr://cedet.bzr.sourceforge.net/bzrroot/cedet/code/trunk"
              :build ("touch `find . -name Makefile`" "make")
              :build/windows-nt ("echo #!/bin/sh > tmp.sh & echo touch `/usr/bin/find . -name Makefile` >> tmp.sh & echo make FIND=/usr/bin/find >> tmp.sh"
                                 "sed 's/^M$//' tmp.sh > tmp2.sh"
                                 "sh ./tmp2.sh" "rm ./tmp.sh ./tmp2.sh")
              :load-path ("./common"))

       (:name magit
              :type git
              :url "http://github.com/magit/magit.git"
              :info "."
              ;; that used to be how to build it :build ("./autogen.sh" "./configure" "make")
              :build ("make all")
              :build/darwin `(,(concat "PATH=" invocation-directory ":$PATH make all")))
       (:name magithub :type git :url "https://github.com/nex3/magithub.git")

       (:name python.el
              :type git
              :url "https://github.com/fgallina/python.el.git")
       (:name ipython
              :type http
              :url "http://ipython.scipy.org/dist/ipython.el"
              :features ipython
              :post-init (lambda ()
                    (setq py-python-command "ipython")))

       (:name haskell-mode
              :type darcs
              :url "http://code.haskell.org/haskellmode-emacs"
              :load "haskell-site-file.el"
              :post-init (lambda ()
                    (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
                    (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)))

       (:name haskell-mode-exts
              :type git
              :url "http://github.com/chrisdone/haskell-mode-exts.git"
              :load-path (".")
              :features (haskell-align-imports haskell-installed-packages haskell-navigate-imports haskell-sort-imports inf-haskell-send-cmd))
       (:name smart-tab
              :type git
              :url "https://github.com/genehack/smart-tab.git"
              :features smart-tab)
       (:name scala-mode
              :type svn
              :url "http://lampsvn.epfl.ch/svn-repos/scala/scala-tool-support/trunk/src/emacs/"
              :build ("make")
              :load-path (".")
              :features scala-mode-auto)


       (:name slime
              :type git
              :module "slime"
              :info "doc"
              :url "https://github.com/nablaone/slime.git"
              :load-path ("." "contrib")
              :compile (".")
              )

       (:name doxymacs
              :type git
              :url "git://doxymacs.git.sourceforge.net/gitroot/doxymacs/doxymacs"
              :load-path ("./lisp")
              :build ("./bootstrap" "./configure" "make")
              :features doxymacs)))

(el-get 'sync)
