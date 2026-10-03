;;; +os.el -*- lexical-binding: t; -*-

(when (or (featurep :system 'macos)
          (featurep :system 'linux))
  (setq shell-command-switch "-c"))

(use-package! edit-server
  :config
  (add-hook! 'server-after-make-frame-hook #'+edit-server-start-h)
  (+edit-server-start-h))

(use-package! clipmon
  :config
  (clipmon-mode-start))

(after! pass
  (set-popup-rule! "^\\*Password-Store" :side 'left :size 0.4 :quit nil)
  (after! recentf
    (+recentf-exclude-path (password-store-dir))))

(map! :leader
      (:prefix ("P" . "password-store")
       :desc "Copy secret"
       "w" #'+pass/copy-secret-to-kill-ring
       :desc "Copy username"
       "b" #'+pass/copy-username-to-kill-ring
       :desc "Copy field"
       "f" #'password-store-copy-field
       :desc "Copy URL"
       "u" #'+pass/copy-url-to-kill-ring
       :desc "Open URL"
       "U" #'+pass/open-url
       :desc "Edit entry"
       "c" #'password-store-edit))

(after! plstore
  (after! epa
    (setq plstore-encrypt-to epa-file-encrypt-to)))

(use-package! password-generator
  :commands (password-generator-words))
