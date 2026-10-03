;;; +ui.el -*- lexical-binding: t; -*-

(setq display-line-numbers-type 'relative
      initial-scratch-message (+ui--get-scratch-message))

(setq-default left-fringe-width 8
              right-fringe-width 8
              display-fill-column-indicator-character ?·)

(blink-cursor-mode t)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(after! doom-modeline
  (setq doom-modeline-height 40)

  (doom-modeline-def-modeline 'main
    '(workspace-name window-number bar modals matches buffer-info-simple buffer-position selection-info)
    '(debug compilation misc-info persp-name input-method indent-info buffer-encoding major-mode process check vcs)))

(after! neotree
  (setq doom-themes-neotree-enable-variable-pitch nil
        doom-themes-neotree-enable-folder-icons nil
        doom-themes-neotree-file-icons nil))

(after! indent-bars
  (setq indent-bars-display-on-blank-lines nil))

(use-package! ultra-scroll
  :init
  (setq scroll-conservatively 3
        scroll-margin 0)
  :config
  (ultra-scroll-mode 1))

(use-package! dashboard
  :config
  (setq dashboard-set-init-info t
        dashboard-startup-banner (expand-file-name "resources/doomemacs.txt" doom-private-dir)
        dashboard-items '((projects . 3)
                          (recents  . 10)))
  (dashboard-setup-startup-hook))

(setq doom-theme 'doom-solarized-dark
      doom-font (font-spec :family "Consolas ligaturized v3" :size 17 :weight 'normal))

(custom-theme-set-faces! 'doom-solarized-dark
  '(consult-highlight-match :background "Springgreen2" :foreground "DimGray")
  '(orderless-match-face-0 :background "Springgreen2" :foreground "DimGray")
  '(orderless-match-face-1 :background "#033445" :foreground "#4b8eba")
  '(font-lock-constant-face :foreground "#859900")
  '(font-lock-keyword-face :foreground "#5ac8f5")
  '(font-lock-number-face :foreground "dark gray")
  '(iedit-occurrence :foreground "Springgreen2" :background "DimGray")
  '(isearch :background "Springgreen2" :foreground "DimGray")
  '(lsp-face-highlight-textual :background "Springgreen2" :foreground "DimGray")
  '(mode-line :box nil :overline nil :underline nil)
  '(mode-line-inactive :box nil :overline nil :underline nil)
  '(rainbow-delimiters-depth-2-face :foreground "#5ac8f5")
  '(rainbow-delimiters-depth-7-face :foreground "#5ac8f5")
  '(region :foreground "SkyBlue" :background "DarkSlateGray")
  '(show-paren-match :background "Springgreen2" :foreground "DimGray")
  `(window-divider :foreground ,+ui--hl-line-background))
