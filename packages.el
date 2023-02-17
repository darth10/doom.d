;;; ~/.doom.d/packages.el -*- no-byte-compile: t; -*-

(package! bufler)
(package! chess)
(package! cider-eval-sexp-fu)
(package! clipmon)
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
(package! nov)
(package! password-generator)
(package! powershell)

(package! flycheck-joker :disable t)
(package! org-superstar :disable t)

(when IS-WINDOWS
  (package! forge :disable t))

(package! transient :pin "c2bdf7e12c530eb85476d3aef317eb2941ab9440")
(package! with-editor :pin "391e76a256aeec6b9e4cbd733088f30c677d965b")
