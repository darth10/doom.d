;;; ~/.doom.d/+editor.el -*- lexical-binding: t; -*-

(when IS-LINUX
  (toggle-debug-on-error))

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(setq uniquify-buffer-name-style 'forward
      uniquify-separator "/"
      uniquify-after-kill-buffer-p t
      global-visual-line-mode nil)

(remove-hook! 'text-mode-hook #'visual-line-mode)

(after! dired
  (remove-hook! 'dired-mode-hook #'dired-omit-mode))

(after! flycheck
  (setq flycheck-emacs-lisp-load-path 'inherit))

(after! yasnippet
  (setq yas-indent-line 'fixed))

(after! which-key
  :init
  (which-key-setup-side-window-bottom)
  (which-key-enable-god-mode-support)
  (setq which-key-max-description-length 24
        which-key-max-display-columns 4
        which-key-separator " : ")
  (which-key-mode t))

(after! lispy
  (setq lispy-key-theme '(paredit c-digits))
  (lispy-set-key-theme lispy-key-theme))

(after! calculator
  (advice-add 'calculator :after (λ! (enlarge-window 2))))

(after! tramp
  ;; File paths like `/sshx:user@remotehost|sudo:remotehost:/etc/dhcpd.conf`
  ;; will open remote files over multiple hops.
  (setq
   ;; tramp-debug-buffer t
   ;; tramp-verbose 9
   tramp-default-method "scpx"))

(after! helm
  (setq helm-allow-mouse t))

(use-package! helm-swoop
  :after helm
  :commands (helm-swoop))

(use-package! helm-ls-git
  :after helm
  :commands (helm-ls-git-ls))
