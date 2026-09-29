;;; ~/.doom.d/autoload/vc.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +vc-pr-review-forge-pr-at-point ()
  "Open `pr-review' for the forge pull-request at point."
  (interactive)
  (if-let* ((pullreq (or (forge-pullreq-at-point) (forge-current-pullreq))))
      (progn
        (require 'pr-review)
        (pr-review (forge-get-url pullreq)))
    (user-error "No pull-request at point")))

;;;###autoload
(defun +magit--branch-checked-out-p (branch)
  "Non-nil if BRANCH is checked out in any worktree."
  (seq-some (lambda (wt) (equal (nth 2 wt) branch))
            (magit-list-worktrees)))
