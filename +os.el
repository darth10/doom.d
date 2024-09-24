;;; ~/.doom.d/+os.el -*- lexical-binding: t; -*-

(when (or (featurep :system 'macos)
          (featurep :system 'linux))
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
    (add-to-list 'recentf-exclude (concat (file-truename (expand-file-name (getenv "PASSWORD_STORE_DIR"))) ".+"))))

(after! plstore
  (after! epa
    (setq plstore-encrypt-to epa-file-encrypt-to)))

(use-package! password-generator
  :commands (password-generator-words))
