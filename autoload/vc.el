;;; ~/.doom.d/autoload/vc.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +vc-approve-with-feedback ()
  (interactive)
  (let* ((feedback (read-string "Enter approval message: ")))
    (code-review-submit-approve feedback)))

;;;###autoload
(defun +code-review-delta-colorize ()
  "Colorize the raw diff with delta before code-review washes it.
Must run first in `code-review-sections-hook', while the region after
point still holds the unwashed diff."
  (when (require 'magit-delta nil t)
    (save-excursion
      (save-restriction
        (narrow-to-region (point) (point-max))
        (magit-delta-call-delta-and-convert-ansi-escape-sequences)))))
