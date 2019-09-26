;;; ~/.doom.d/autoload/editor.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +editor/match-paren ()
  "Go to the matching paren if the cursor is on a paren."
  (interactive)
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (message "%s" "No parenthesis under cursor!"))))

;;;###autoload
(defun +editor/kill-region-or-line (beg end)
  "Copy current line to kill ring."
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list (line-beginning-position)
                       (line-beginning-position 2))))
  (kill-region beg end))

;;;###autoload
(defun +editor/kill-ring-save-region-or-line (beg end)
  "Copy current line to kill ring."
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list (line-beginning-position)
                       (line-beginning-position 2))))
  (kill-ring-save beg end))
