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

(after! pass
  (set-popup-rule! "^\\*Password-Store" :side 'left :size 0.4 :quit nil)
  (after! recentf
    (add-to-list 'recentf-exclude (concat (expand-file-name (getenv "PASSWORD_STORE_DIR")) ".+"))))
