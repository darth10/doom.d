;;; ~/.doom.d/autoload/org.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +org/recalculate-all ()
  "Recalculate the current table line by applying all stored formulas
until it no longer changes."
  (interactive)
  (when (org-at-table-p)
    (org-table-recalculate 'iterate)))
