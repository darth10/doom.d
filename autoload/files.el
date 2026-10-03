;;; autoload/files.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +recentf-exclude-path (path)
  "Exclude files under PATH from `recentf-list'.
Both the resolved and abbreviated forms of PATH are excluded."
  (let ((resolved-path (file-truename path)))
    (dolist (p (list resolved-path (abbreviate-file-name resolved-path)))
      (add-to-list 'recentf-exclude (concat "\\`" (regexp-quote p))))))
