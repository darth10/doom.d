;;; ~/.doom.d/autoload/vc.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +vc-approve-with-feedback ()
  (interactive)
  (let* ((feedback (read-string "Enter approval message: ")))
    (code-review-submit-approve feedback)))
