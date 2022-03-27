;;; ~/.doom.d/+vc.el -*- lexical-binding: t; -*-

(after! magit
  (setq magit-commit-show-diff nil)

  (defun +magit--get-default-branch ()
    (or (magit-get "remote.origin.default-branch") "master"))

  (transient-define-suffix +magit-fetch-origin-default-branch (branch)
    "Runs 'git fetch origin branch:branch' where 'branch' is the
value of the 'remote.origin.default-branch' configuration
variable or 'master'."
    :description (lambda () (let ((branch (+magit--get-default-branch)))
                              (format "origin %s:%s" branch branch)))
    (interactive (list (+magit--get-default-branch)))
    (magit-run-git-async "fetch" "origin" (format "%s:%s" branch branch)))

  (transient-append-suffix 'magit-fetch "o"
    '("O" +magit-fetch-origin-default-branch)))

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
