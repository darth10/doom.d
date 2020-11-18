;;; ~/.doom.d/+files.el -*- lexical-binding: t; -*-

(after! persist
  (setq persist--directory-location (concat doom-cache-dir "persist")))

(use-package! nov
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (setq nov-save-place-file (concat doom-cache-dir "nov-places")))

(after! pdf-tools
  (setq-default pdf-view-display-size 'fit-width)
  (add-hook! 'pdf-view-mode-hook #'pdf-view-midnight-minor-mode))
