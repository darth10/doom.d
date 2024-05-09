;;; ~/.doom.d/+editor.el -*- lexical-binding: t; -*-

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'scroll-right 'disabled nil)

(when (functionp 'repeat-mode)
  (repeat-mode t))

(setq uniquify-buffer-name-style 'forward
      uniquify-separator "/"
      uniquify-after-kill-buffer-p t
      global-visual-line-mode nil)

(remove-hook! 'text-mode-hook #'visual-line-mode)

(use-package! ialign
  :commands (ialign))

(after! dired
  (remove-hook! 'dired-mode-hook #'dired-omit-mode))

(after! flycheck
  (setq flycheck-emacs-lisp-load-path 'inherit))

(after! yasnippet
  (setq yas-indent-line 'fixed))

(after! company-box
  (setq company-box-scrollbar nil))

(after! which-key
  (which-key-enable-god-mode-support)
  (setq which-key-separator " : "))

(after! lispy
  (lispy-set-key-theme (setq lispy-key-theme '(paredit c-digits))))

(after! calculator
  (advice-add 'calculator :after (λ! (set-window-text-height nil 1))))

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
