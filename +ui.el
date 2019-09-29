;;; ~/.doom.d/+ui.el -*- lexical-binding: t; -*-

(setq initial-scratch-message (+ui--get-scratch-message))

(setq-default left-fringe-width 8
              right-fringe-width 8)

(add-hook! 'doom-switch-buffer-hook
  (defun +ui--switch-buffer-hook ()
    (blink-cursor-mode                  ; Disable blinking cursor in PDFs.
     (if (eq major-mode 'pdf-view-mode)
         -1 +1))))

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

(use-package! highlight-sexp
  :commands (highlight-sexp-mode)
  :hook (highlight-sexp-mode . +highlight-sexp--set-hl-line)
  :config
  (defun +highlight-sexp--set-hl-line ()
    (hl-line-mode (if highlight-sexp-mode -1 +1))))

(after! hl-line
  (let ((hl-line-background (face-background 'hl-line)))
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
