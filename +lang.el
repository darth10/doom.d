;;; ~/.doom.d/+lang.el -*- lexical-binding: t; -*-

;;; Emacs Lisp

(after! lisp-mode
  (setq lisp-prettify-symbols-alist nil))

(use-package! eval-sexp-fu
  :hook ((lisp-mode emacs-lisp-mode eshell-mode) . +eval-sexp-fu--init)
  :custom-face
  (eval-sexp-fu-flash ((t (:foreground "DodgerBlue" :background "DimGray"))))
  :config
  (defun +eval-sexp-fu--init ()
    (require 'eval-sexp-fu)))

;;; Clojure

(after! clojure-mode
  (define-clojure-indent
   (GET 2)
   (POST 2)
   (PUT 2)
   (PATCH 2)
   (DELETE 2)
   (match 1)
   (friend/authorize 1)
   (featureflag 1))

  (plist-put +ligatures-extra-symbols :fn '(?\s (Br . Bl) ?\s (Bc . Bc) ?𝝺))

  (set-ligatures! 'clojure-mode
    :fn "fn")

  (defadvice! +clojure-thread-first-all-a (&rest _)
    :after #'clojure-thread-first-all
    (+clojure-thread-oneline))

  (defadvice! +clojure-thread-last-all-a (&rest _)
    :after #'clojure-thread-last-all
    (+clojure-thread-oneline))

  (add-hook! 'clojure-ts-mode-hook #'clojure-mode-variables)
  (add-hook! 'clojurescript-mode-hook #'+lsp-enable-eldoc-local))

(after! cider
  (remove-hook! cider--debug-mode
    'turn-off-evil-snipe-mode
    'turn-off-evil-snipe-override-mode))

(use-package! cider-eval-sexp-fu
  :after (clojure-mode cider))

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
  (set-repl-handler! 'gnuplot-mode #'gnuplot-show-gnuplot-buffer))

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


(after! plantuml-mode
  (setq plantuml-default-exec-mode 'jar))

(after! nix-mode
  (set-formatter! 'alejandra '("alejandra" "--quiet") :modes '(nix-mode)))

(after! lsp-nix
  (setq lsp-nix-nil-auto-eval-inputs nil
        lsp-nix-nil-formatter ["alejandra"]))

(after! auctex
  (add-hook! 'LaTeX-mode-hook
             #'auto-fill-mode #'prettify-symbols-mode)

  (setq +latex-viewers '(pdf-tools skim evince sumatrapdf zathura okular)))
