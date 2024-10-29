;;; ~/.doom.d/autoload/editor.el -*- lexical-binding: t; -*-

(defun +editor--move-text (arg)
   (cond
    ((and mark-active transient-mark-mode)
     (if (> (point) (mark))
            (exchange-point-and-mark))
     (let ((column (current-column))
              (text (delete-and-extract-region (point) (mark))))
       (forward-line arg)
       (move-to-column column t)
       (set-mark (point))
       (insert text)
       (exchange-point-and-mark)
       (setq deactivate-mark nil)))
    (t
     (beginning-of-line)
     (when (or (> arg 0) (not (bobp)))
       (forward-line)
       (when (or (< arg 0) (not (eobp)))
            (transpose-lines arg))
       (forward-line -1)))))

;;;###autoload
(defun +editor/move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  ARG lines down."
  (interactive "*p")
  (+editor--move-text arg))

;;;###autoload
(defun +editor/move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  ARG lines up."
  (interactive "*p")
  (+editor--move-text (- arg)))

;;;###autoload
(defun +editor/delete-single-window (&optional window)
  "Close window WINDOW and kill it's buffer.
WINDOW defaults to current window."
  (interactive)
  (save-current-buffer
    (setq window (or window (selected-window)))
    (select-window window)
    (kill-buffer)
    (if (one-window-p t)
        (delete-frame)
      (delete-window (selected-window)))))

;;;###autoload
(defun +lsp-enable-eldoc-local ()
  (set (make-local-variable 'lsp-eldoc-enable-hover) t))
