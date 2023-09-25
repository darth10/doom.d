;;; ~/.doom.d/autoload/games.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +monkeytype-god-mode ()
  (when (and (boundp 'monkeytype-mode) monkeytype-mode)
    (if god-local-mode
        (call-interactively #'monkeytype-pause)
      (call-interactively #'monkeytype-resume))))
