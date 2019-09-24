;;; ~/.doom.d/autoload/editor.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +editor/match-paren ()
  "Go to the matching paren if the cursor is on a paren."
  (interactive)
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (message "%s" "No parenthesis under cursor!"))))
