;;; ~/.doom.d/packages.el -*- no-byte-compile: t; -*-

(package! ascii-art-to-unicode)
(package! chess)
(package! cider-eval-sexp-fu)
(package! clipmon)
(package! dashboard)
(package! edit-server)
(package! esup)
(package! eval-sexp-fu)
(package! feature-mode)
(package! ghub)
(package! god-mode)
(package! highlight-sexp)
(package! ialign)
(package! k8s-mode)
(package! kubernetes)
(package! magit-delta)
(package! monkeytype)
(package! nov)
(package! password-generator)
(package! powershell)

(package! flycheck-joker :disable t)
(package! org-superstar :disable t)

(when IS-WINDOWS
  (package! forge :disable t))
