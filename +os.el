;;; ~/.doom.d/+os.el -*- lexical-binding: t; -*-

(use-package! edit-server
  :if window-system
  :defer 2
  :config
  (edit-server-start))

(use-package! clipmon
  :defer 2
  :config
  (clipmon-mode-start))
