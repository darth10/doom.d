;;; ~/.doom.d/packages.el -*- no-byte-compile: t; -*-

(package! clipmon)
(package! chess)
(package! edit-server)
(package! god-mode)
(package! ghub)
(package! helm-ls-git)
(package! helm-swoop)
(package! highlight-sexp)
(package! nov)
(package! k8s-mode)
(package! kubernetes)
(package! unicode-fonts)

(package! cider-eval-sexp-fu)
(package! eval-sexp-fu)
(package! flycheck-clj-kondo)
(package! powershell)

(package! flycheck-joker :disable t)
(package! swiper-helm :disable t)

(when IS-WINDOWS
  (package! forge :disable t))
