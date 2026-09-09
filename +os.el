;;; ~/.doom.d/+os.el -*- lexical-binding: t; -*-

(when (or (featurep :system 'macos)
          (featurep :system 'linux))
  (setq shell-command-switch "-c"))

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
    (let* ((resolved-password-store-dir (file-truename (password-store-dir))))
      (dolist (dir (list resolved-password-store-dir
                         (abbreviate-file-name resolved-password-store-dir)))
        (add-to-list 'recentf-exclude (concat "\\`" (regexp-quote dir)))))))

(after! plstore
  (after! epa
    (setq plstore-encrypt-to epa-file-encrypt-to)))

(use-package! password-generator
  :commands (password-generator-words))

(after! vterm
  (add-hook! 'vterm-mode-hook #'+vterm-font-setup))
