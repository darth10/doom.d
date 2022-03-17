;;; ~/.doom.d/+vc.el -*- lexical-binding: t; -*-

(after! magit
  (setq magit-commit-show-diff nil))

(after! forge
;; forge-pull-notifications fails for a large number of notifications
  (setq forge-pull-notifications nil)
  (transient-append-suffix 'magit-branch "w"
    '("y" "pull request" forge-checkout-pullreq))
  (transient-append-suffix 'magit-branch "W"
    '("Y" "from pull request" forge-branch-pullreq)))

(use-package! magit-delta
  :hook (magit-mode . magit-delta-mode)
  :after magit
  :config
  (setq magit-delta-default-dark-theme "Nord"
        magit-delta-hide-plus-minus-markers nil)
  ;; These colors are obtained from `delta --show-config`
  (set-face-attribute 'magit-diff-added-highlight nil
                      :background "#002800")
  (set-face-attribute 'magit-diff-added nil
                      :background "#002800")
  (set-face-attribute 'magit-diff-removed-highlight nil
                      :background "#3f0001")
  (set-face-attribute 'magit-diff-removed nil
                      :background "#3f0001")
  (add-hook 'magit-delta-mode-hook
            (lambda ()
              (setq face-remapping-alist
                    (seq-difference face-remapping-alist
                                    '((magit-diff-removed . default)
                                      (magit-diff-removed-highlight . default)
                                      (magit-diff-added . default)
                                      (magit-diff-added-highlight . default)))))))
