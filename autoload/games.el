;;; ~/.doom.d/autoload/games.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +monkeytype-evil-normal-mode ()
  (when (and (boundp 'monkeytype-mode)
             monkeytype-mode)
    (when (and evil-normal-state-minor-mode
               (boundp 'monkeytype--start-time)
               monkeytype--start-time)
      (call-interactively #'monkeytype-pause))
    (when evil-insert-state-minor-mode
      (call-interactively #'monkeytype-resume))))
