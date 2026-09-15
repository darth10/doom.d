;;; ~/.doom.d/autoload/vc.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +vc-pr-review-forge-pr-at-point ()
  "Open `pr-review' for the forge pull-request at point."
  (interactive)
  (if-let* ((pullreq (or (forge-pullreq-at-point) (forge-current-pullreq))))
      (pr-review (forge-get-url pullreq))
    (user-error "No pull-request at point")))
