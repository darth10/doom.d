;;; ~/.doom.d/+ui.el -*- lexical-binding: t; -*-

(setq initial-scratch-message (+ui--get-scratch-message))

(setq-default left-fringe-width 8
              right-fringe-width 8)

(add-hook! '(doom-switch-buffer-hook
             doom-switch-frame-hook
             doom-switch-window-hook)
           #'+ui--switch-buffer-or-frame-h)

(remove-hook! 'text-mode-hook #'vi-tilde-fringe-mode)
(remove-hook! 'prog-mode-hook #'vi-tilde-fringe-mode)

(blink-cursor-mode t)

(when IS-WINDOWS
  ;; Using `add-hook!' doesn't work here.
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
    '(debug misc-info persp-name input-method indent-info buffer-encoding major-mode process vcs checker))

  (doom-modeline-def-modeline 'helm
    '(bar helm-number helm-follow helm-prefix-argument)
    '(helm-help)))

(after! (:and god-mode doom-modeline)
  (defun +ui--configure-modeline-indicator-h ()
    "Configure modeline indicator depending on mode."
    (let* ((is-god-mode (bound-and-true-p god-local-mode))
           (next-mode-string (cond ((or is-god-mode
                                        (and overwrite-mode is-god-mode)) ":")
                                   (overwrite-mode "!")
                                   (t " "))))
      (setq core--modeline-mode-string next-mode-string)))

  (add-hook! 'post-command-hook #'+ui--configure-modeline-indicator-h))


(after! doom-themes
  ;; `doom-load-theme-hook' functions need to be run to properly enable
  ;; `solaire-mode'.
  (when (equal custom-enabled-themes '(doom-solarized-dark))
    (run-hooks 'doom-load-theme-hook)))

(use-package! unicode-fonts
  :defer 2
  :config
  (unicode-fonts-setup))

(use-package! highlight-sexp
  :commands (highlight-sexp-mode)
  :hook (highlight-sexp-mode . +highlight-sexp--set-hl-line)
  :config
  (defun +highlight-sexp--set-hl-line ()
    (hl-line-mode (if highlight-sexp-mode -1 +1))))

(after! (:and solaire-mode highlight-sexp)
  (let ((hl-line-background (face-background 'solaire-hl-line-face)))
    (custom-set-variables
     `(hl-sexp-background-color ,hl-line-background))))

(let ((default-height (if IS-LINUX 148 138)))
  (custom-set-variables
   '(custom-enabled-themes '(doom-solarized-dark))
   '(custom-safe-themes
     '("428754d8f3ed6449c1078ed5b4335f4949dc2ad54ed9de43c56ea9b803375c23" default)))
  (custom-set-faces
   `(default ((t (:height ,default-height :family "Consolas" :weight normal :width normal))))
   '(doom-modeline-buffer-modified ((t (:inherit (warning bold) :background nil))))
   '(doom-modeline-inactive-bar ((t (:inherit mode-line-emphasis))))
   '(doom-modeline-panel ((t (:inherit mode-line-emphasis))))
   '(eval-sexp-fu-flash ((t (:foreground "DodgerBlue" :background "DimGray"))))
   '(helm-selection ((t (:inherit bold :foreground "DodgerBlue" :background "DarkSlateGray"))))
   '(helm-swoop-target-word-face ((t (:background "Springgreen2" :foreground "DimGray"))))
   '(iedit-occurrence ((t (:foreground "Springgreen2" :background "DimGray"))))
   '(isearch ((t (:background "Springgreen2" :foreground "DimGray"))))
   '(mode-line ((t (:box nil :overline nil :underline nil))))
   '(mode-line-inactive ((t (:box nil :overline nil :underline nil))))
   '(show-paren-match ((t (:background "Springgreen2" :foreground "DimGray"))))))
