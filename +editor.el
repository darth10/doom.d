;;; +editor.el -*- lexical-binding: t; -*-

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'scroll-right 'disabled nil)

(repeat-mode t)

(setq uniquify-buffer-name-style 'forward
      uniquify-separator "/"
      uniquify-after-kill-buffer-p t)

(use-package! ialign
  :commands (ialign))

(use-package! rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(after! dired
  (remove-hook! 'dired-mode-hook #'dired-omit-mode))

(after! flycheck
  (setq flycheck-emacs-lisp-load-path 'inherit))

(after! yasnippet
  (setq yas-indent-line 'fixed))

(after! which-key
  (setq which-key-separator ": "))

(after! lispyville
  (lispyville-set-key-theme
   '((operators normal)
     c-w
     (prettify insert)
     (atom-movement t)
     slurp/barf-lispy
     commentary
     wrap
     additional
     additional-insert
     (additional-movement normal visual motion))))

(after! calculator
  (defadvice! +calculator-shrink-window-a (&rest _)
    :after #'calculator
    (set-window-text-height nil 1)))

(after! tramp
  ;; File paths like `/sshx:user@remotehost|sudo:remotehost:/etc/dhcpd.conf`
  ;; will open remote files over multiple hops.
  (setq
   ;; tramp-debug-buffer t
   ;; tramp-verbose 9
   tramp-default-method "scpx"))

(after! vertico
  (setq vertico-count 10)
  (use-package! vertico-mouse
    :config
    (vertico-mouse-mode t)))

(after! lsp-mode
  (setq lsp-eldoc-enable-hover nil
        lsp-ui-doc-enable nil
        lsp-ui-sideline-enable nil
        lsp-modeline-diagnostics-enable nil))

(use-package! mise
  :when (executable-find "mise")
  :config
  (add-hook! 'doom-init-ui-hook #'global-mise-mode))

(after! ghostel
  (setq ghostel-max-scrollback (* 20 1024 1024)))
