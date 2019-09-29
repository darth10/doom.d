;;; ~/.doom.d/+os.el -*- lexical-binding: t; -*-

(when IS-LINUX
  (setq shell-command-switch "-ic"))

(after! eshell
  (add-hook! 'eshell-mode-hook #'+eshell--load-bash-aliases-in-eshell))

(use-package! edit-server
  :if window-system
  :defer 2
  :config
  (edit-server-start))

(use-package! clipmon
  :defer 2
  :config
  (clipmon-mode-start))
