;;; ~/.doom.d/packages.el -*- no-byte-compile: t; -*-

(package! chess)
(package! clipmon)
(package! edit-server)
(package! ghub)
(package! god-mode)
(package! helm-ls-git)
(package! helm-swoop)
(package! highlight-sexp)
(package! k8s-mode)
(package! kubernetes)
(package! nov)
(package! unicode-fonts)

(package! cider-eval-sexp-fu)
(package! eval-sexp-fu)
(package! powershell)

(package! flycheck-joker :disable t)
(package! org-superstar :disable t)
(package! swiper-helm :disable t)

(when IS-WINDOWS
  (package! forge :disable t))
