;;; ~/.doom.d/+os.el -*- lexical-binding: t; -*-

(when (or IS-MAC IS-LINUX)
  (setq shell-command-switch "-ic"))

(after! eshell
  (add-hook! 'eshell-mode-hook #'+eshell--load-bash-aliases-h))

(use-package! edit-server
  :if window-system
  :config
  (edit-server-start))

(use-package! clipmon
  :config
  (clipmon-mode-start))
