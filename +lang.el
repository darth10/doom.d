;;; +lang.el -*- lexical-binding: t; -*-

;;; Lisps

(use-package! highlight-sexp
  :commands (highlight-sexp-mode)
  :hook (highlight-sexp-mode . +highlight-sexp--set-hl-line)
  :config
  (defun +highlight-sexp--set-hl-line ()
    (hl-line-mode (if highlight-sexp-mode -1 +1)))
  (setopt hl-sexp-background-color +ui--hl-line-background))

(map! :localleader
      (:map (common-lisp-mode-map
             emacs-lisp-mode-map
             scheme-mode-map
             racket-mode-map
             hy-mode-map
             lfe-mode-map
             clojure-mode-map
             clojure-ts-mode-map)
            :desc "Highlight sexp"
            "[" #'highlight-sexp-mode))

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

(plist-put +ligatures-extra-symbols :fn '(?\s (Br . Bl) ?\s (Bc . Bc) ?λ))
(set-ligatures! '(clojure-mode clojure-ts-mode)
  :fn "fn")

(after! clojure-ts-mode
  (setq clojure-ts-semantic-indent-rules
        '(("GET" . ((:block 2)))
          ("POST" . ((:block 2)))
          ("PUT" . ((:block 2)))
          ("PATCH" . ((:block 2)))
          ("DELETE" . ((:block 2)))
          ("defroutes" . ((:block 2)))
          ("authorize" . ((:block 1)))
          ("featureflag" . ((:block 1)))))

  (add-hook! 'clojure-ts-clojurescript-mode-hook #'+lsp-enable-eldoc-local)

  (defadvice! +clojure-ts-thread-first-all-a (&rest _)
    :after #'clojure-ts-thread-first-all
    (+clojure-thread-oneline))

  (defadvice! +clojure-ts-thread-last-all-a (&rest _)
    :after #'clojure-ts-thread-last-all
    (+clojure-thread-oneline))

  (map! (:map (clojure-ts-mode-map
               clojure-ts-clojurescript-mode-map
               clojure-ts-clojurec-mode-map)
              (:localleader
               (:prefix ("f" . "refactor"))
               "f" clojure-ts-refactor-map))))

(after! clojure-mode
  (map! (:map (clojure-mode-map clojurescript-mode-map clojurec-mode-map)
              (:localleader
               (:prefix ("f" . "refactor"))
               "f" clojure-refactor-map))))

(after! clj-refactor
  (map! (:map clj-refactor-map
              "/" nil)))        ; cljr-slash

(after! cider
  ;; This is still needed even though the evil-snipe package is disabled.
  (remove-hook! cider--debug-mode
    'turn-off-evil-snipe-mode
    'turn-off-evil-snipe-override-mode))

(use-package! cider-eval-sexp-fu
  :after (clojure-mode cider))

(use-package! lispy
  :defer t
  :init
  (setq lispy-clojure-modes '(clojure-mode clojurescript-mode clojurex-mode clojurec-mode
                              clojure-ts-mode clojure-ts-clojurescript-mode clojure-ts-clojurec-mode))
  :config
  (dolist (mode lispy-clojure-modes)
    (add-to-list 'lispy-parens-preceding-syntax-alist `(,mode . ("[`'~@]+" "#" "#\\?@?"))))
  (map! (:map lispy-mode-map-lispy
              "[" #'lispy-open-square
              "]" #'lispy-close-square
              "M-r" #'lispy-raise-sexp
              "M-}" #'lispy-splice-sexp-killing-backward
              "M-]" #'lispy-splice-sexp-killing-forward)))

;;; JavaScript

(after! js
  (setq js-indent-level 2))

;;; Web

(after! emmet-mode
  (map! (:map emmet-mode-keymap
              "<tab>" #'emmet-expand-line)))

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

(use-package! auctex
  :defer t
  :init
  (setq +latex-viewers '(pdf-tools skim evince sumatrapdf zathura okular))
  :config
  (add-hook! 'LaTeX-mode-hook
             #'auto-fill-mode #'prettify-symbols-mode))
