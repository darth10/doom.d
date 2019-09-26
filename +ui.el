;;; ~/.doom.d/+ui.el -*- lexical-binding: t; -*-

(setq initial-scratch-message (+ui--get-scratch-message))

(setq-default left-fringe-width 8
              right-fringe-width 8)

(remove-hook! 'text-mode-hook #'vi-tilde-fringe-mode)
(remove-hook! 'prog-mode-hook #'vi-tilde-fringe-mode)

(blink-cursor-mode t)

(when IS-WINDOWS
  (add-hook 'window-setup-hook (λ! (w32-send-sys-command 61488))))

(after! doom-modeline
  (custom-set-faces
   '(doom-modeline-panel ((t (:inherit mode-line-emphasis))))
   '(doom-modeline-buffer-modified ((t (:inherit (warning bold) :background nil))))
   '(doom-modeline-inactive-bar ((t (:inherit mode-line-emphasis)))))

  (setq doom-modeline-height 40)

  (doom-modeline-def-segment cur-mode
    (if (doom-modeline--active)
        '(" " core--modeline-mode-string " ")
      "   "))

  (doom-modeline-def-modeline 'main
    '(workspace-name window-number bar cur-mode matches buffer-info-simple buffer-position selection-info)
    '(debug buffer-encoding major-mode process vcs checker))

  (doom-modeline-def-modeline 'helm
    '(bar helm-number helm-follow helm-prefix-argument)
    '(helm-help)))

(use-package! unicode-fonts
  :defer 2
  :config
  (unicode-fonts-setup))
