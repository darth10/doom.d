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

(use-package! kubernetes
  :commands (kubernetes-overview)
  :hook (kubernetes-mode . +kubernetes--popup-setup)
  :bind (:map kubernetes-mode-map
         ("N" . kubernetes-set-namespace))
  :config
  (defun +kubernetes--popup-setup ()
    (magit-define-popup-action 'kubernetes-overview-popup
      ?N "Set namespace" 'kubernetes-set-namespace ?c)))
