;;; ~/.doom.d/+ui.el -*- lexical-binding: t; -*-

(setq initial-scratch-message (+ui--get-scratch-message))

(setq-default left-fringe-width 8
              right-fringe-width 8
              display-fill-column-indicator-character ?·)

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
  (setq doom-modeline-height 40)

  (doom-modeline-def-segment cur-mode
    (if (doom-modeline--active)
        '(" " core--modeline-mode-string " ")
      "   "))

  (doom-modeline-def-modeline 'main
    '(workspace-name window-number bar cur-mode matches buffer-info-simple buffer-position selection-info)
    '(debug compilation misc-info persp-name input-method indent-info buffer-encoding major-mode process checker vcs)))

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

(after! neotree
  (setq doom-themes-neotree-enable-variable-pitch nil
        doom-themes-neotree-enable-folder-icons nil
        doom-themes-neotree-file-icons nil))

(after! highlight-indent-guides
  (setq highlight-indent-guides-responsive 'stack
        highlight-indent-guides-method 'bitmap))

(use-package! highlight-sexp
  :commands (highlight-sexp-mode)
  :hook (highlight-sexp-mode . +highlight-sexp--set-hl-line)
  :config
  (defun +highlight-sexp--set-hl-line ()
    (hl-line-mode (if highlight-sexp-mode -1 +1)))
  (setq! hl-sexp-background-color +ui--hl-line-background))

(use-package! dashboard
  :config
  (setq dashboard-set-init-info t
        dashboard-set-footer nil
        dashboard-startup-banner (expand-file-name "resources/doomemacs.txt" doom-private-dir)
        dashboard-items '((projects . 3)
                          (recents  . 10)))
  (dashboard-setup-startup-hook))

(let ((default-height (cond (IS-LINUX 148)
                            (IS-MAC 166)
                            (t 138))))
  (setq! doom-theme 'doom-solarized-dark)
  (custom-set-faces
   `(default ((t (:height ,default-height :family "Consolas" :weight normal :width normal))))
   '(doom-modeline-buffer-modified ((t (:inherit (warning bold) :background nil))))
   '(doom-modeline-inactive-bar ((t (:inherit mode-line-emphasis))))
   '(doom-modeline-panel ((t (:inherit mode-line-emphasis))))
   '(consult-highlight-match ((t (:background "Springgreen2" :foreground "DimGray"))))
   '(orderless-match-face-0 ((t (:background "Springgreen2" :foreground "DimGray"))))
   '(orderless-match-face-1 ((t (:background "#033445" :foreground "#4b8eba"))))
   '(eval-sexp-fu-flash ((t (:foreground "DodgerBlue" :background "DimGray"))))
   '(font-lock-constant-face ((t (:foreground "#859900"))))
   '(font-lock-keyword-face ((t (:foreground "#5ac8f5"))))
   '(highlight-numbers-number ((t (:foreground "#2aa198"))))
   '(iedit-occurrence ((t (:foreground "Springgreen2" :background "DimGray"))))
   '(isearch ((t (:background "Springgreen2" :foreground "DimGray"))))
   '(lsp-face-highlight-textual ((t (:background "Springgreen2" :foreground "DimGray"))))
   '(mode-line ((t (:box nil :overline nil :underline nil))))
   '(mode-line-inactive ((t (:box nil :overline nil :underline nil))))
   '(rainbow-delimiters-depth-2-face ((t (:foreground "#5ac8f5"))))
   '(region ((t (:foreground "SkyBlue" :background "DarkSlateGray"))))
   '(show-paren-match ((t (:background "Springgreen2" :foreground "DimGray"))))
   `(window-divider ((t (:foreground ,+ui--hl-line-background))))
   '(ivy-minibuffer-match-face-1 ((t (:background "Springgreen2" :foreground "DimGray"))))
   '(ivy-minibuffer-match-face-2 ((t (:background "Springgreen2" :foreground "DimGray"))))
   '(swiper-background-match-face-2 ((t (:background "Springgreen2" :foreground "DimGray"))))
   '(swiper-match-face-1 ((t (:background "Springgreen2" :foreground "DimGray"))))
   '(swiper-match-face-2 ((t (:background "Springgreen2" :foreground "DimGray"))))
   '(swiper-match-face-3 ((t (:background "Springgreen2" :foreground "DimGray"))))
   '(swiper-line-face ((t (:inherit bold :foreground "DodgerBlue" :background "DarkSlateGray"))))
   '(yaml-tab-face ((t (:inherit whitespace-tab))))))
