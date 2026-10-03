;;; +files.el -*- lexical-binding: t; -*-

(after! persist
  (setq persist--directory-location (concat doom-cache-dir "persist")))

(after! recentf
  (+recentf-exclude-path "~/.authinfo.gpg")
  (+recentf-exclude-path (doom-profile-data-dir t "workspaces/")))

(use-package! nov
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (setq nov-save-place-file (concat doom-cache-dir "nov-places")))

(after! pdf-tools
  (setq-default pdf-view-display-size 'fit-width)
  (add-hook! 'pdf-view-mode-hook #'pdf-view-themed-minor-mode)
  (add-hook! 'pdf-view-mode-hook (lambda () (setq-local cursor-type nil))))
