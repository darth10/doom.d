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

  (transient-define-suffix +magit-fetch-all (branch)
    "Runs 'forge-pull' and 'git fetch origin branch:branch --prune' where 'branch' is the
value of the 'remote.origin.default-branch' configuration variable or
'master'."
    :description (lambda () (let ((branch (+magit--get-default-branch)))
                         (format "forge topics, fetch origin --prune %s:%s" branch branch)))
    (interactive (list (+magit--get-default-branch)))
    (when (fboundp 'forge-pull) (forge-pull))
    (magit-run-git-async "fetch" "origin" "--prune" "+refs/heads/*:refs/remotes/origin/*" (format "%s:%s" branch branch)))

  (transient-append-suffix 'magit-fetch "o"
    '("O" +magit-fetch-origin-default-branch)))

(after! ghub
  ;; ghub 5.1+ moved `ghub-graphql' (used by code-review) to ghub-legacy.el
  (require 'ghub-legacy nil t))

(after! forge
  ;; forge-pull-notifications fails for a large number of notifications
  (setq forge-pull-notifications nil
        forge-topic-list-limit '(10 . 5))
  (transient-append-suffix 'magit-fetch "N"
    '("A" +magit-fetch-all))
  (transient-append-suffix 'magit-merge "y"
    '("Y" "approve pull-request" forge-approve-pullreq)))

(after! code-review
  (setq code-review-new-buffer-window-strategy #'switch-to-buffer)
  (set-popup-rule! "^\\*Code Review" :ignore t)
  (add-hook 'code-review-sections-hook #'+code-review-delta-colorize)
  (transient-append-suffix 'magit-branch "x"
    '("o" "review pull-request" +magit/start-code-review)))

(use-package! magit-todos
  :after magit
  :config
  (setq magit-todos-keyword-suffix "\\(?:([^)]+)\\)?:?") ; make colon optional
  (magit-todos-mode t))

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
  (add-hook! 'magit-delta-mode-hook
    (setq face-remapping-alist
          (seq-difference face-remapping-alist
                          '((magit-diff-removed . default)
                            (magit-diff-removed-highlight . default)
                            (magit-diff-added . default)
                            (magit-diff-added-highlight . default))))))
