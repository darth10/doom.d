;;; ~/.doom.d/+lang.el -*- lexical-binding: t; -*-


;;; Emacs Lisp

(use-package! eval-sexp-fu
  :hook ((lisp-mode emacs-lisp-mode eshell-mode) . +eval-sexp-fu--init)
  :custom-face
  (eval-sexp-fu-flash ((t (:foreground "DodgerBlue" :background "DimGray"))))
  :config
  (defun +eval-sexp-fu--init ()
    (require 'eval-sexp-fu)))

;;; Clojure

(after! cider
  (require 'flycheck-clj-kondo))

(use-package! cider-eval-sexp-fu
  :after (clojure-mode cider))

;;; Racket

(after! racket-mode
  (add-to-list 'auto-mode-alist '("\\.rkt\\'" . racket-mode)))

;;; Org

(after! org
  (remove-hook! 'org-mode-hook #'org-bullets-mode)
  (setq org-startup-indented nil
        org-eldoc-breadcrumb-separator " > "))

(after! ox-reveal
  (setq org-reveal-root "https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.8.0/"))
