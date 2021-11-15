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
