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

(use-package! cider-eval-sexp-fu
  :after (clojure-mode cider))

;;; Racket

(after! racket-mode
  (add-to-list 'auto-mode-alist '("\\.rkt\\'" . racket-mode)))

;;; JavaScript

(after! js2-mode
  (setq js2-basic-offset 2))

;;; PowerShell

(use-package! powershell
  :mode (("\\.ps1\\'" . powershell-mode)
         ("\\.psm1\\'" . powershell-mode)))

;;; SQL

(after! sql
  (add-to-list 'process-coding-system-alist '("sqlcmd" . cp850-dos))
  (setq sql-ms-program "sqlcmd"
        sql-ms-options nil))

;;; gnuplot

(use-package! gnuplot
  :mode ("\\.gnuplot\\'" . gnuplot-mode)
  :hook
  (gnuplot-mode . gnuplot-inline-display-mode)
  (gnuplot-mode . display-line-numbers-mode)
  :config
  (set-repl-handler! 'gnuplot-mode #'gnuplot-show-gnuplot-buffer)
  (map! :map gnuplot-mode-map
        "C-c C-k" #'gnuplot-send-buffer-to-gnuplot))

;;; markdown

(after! grip-mode
  (defadvice! +markdown-grip-load-password-a (&rest _)
    :before #'grip-mode
    (let* ((host "api.github.com")
           (match (car (auth-source-search :host host))))
      (if match
          (let* ((secret-list (plist-get match :secret))
                 (secret (if (functionp secret-list)
                             (funcall secret-list)
                           secret-list)))
            (setq grip-github-password secret))
        (doom-log "Password not found for %S" host)))))
