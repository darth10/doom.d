;;; ~/.doom.d/+files.el -*- lexical-binding: t; -*-

(after! persist
  (setq persist--directory-location (concat doom-cache-dir "persist")))

(after! recentf
  (add-to-list 'recentf-exclude (expand-file-name "~/.authinfo.gpg"))
  (add-to-list 'recentf-exclude (expand-file-name "~/projects/doom-emacs/.local/etc/workspaces/"))
  (add-to-list 'recentf-exclude (expand-file-name "~/.emacs.d/.local/etc/workspaces/")))

(use-package! nov
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (setq nov-save-place-file (concat doom-cache-dir "nov-places")))

(after! pdf-tools
  (setq-default pdf-view-display-size 'fit-width)
  (add-hook! 'pdf-view-mode-hook #'pdf-view-themed-minor-mode))
