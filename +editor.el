;;; +editor.el -*- lexical-binding: t; -*-

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'scroll-right 'disabled nil)

(repeat-mode t)

(put 'previous-buffer 'repeat-map '+editor-buffer-repeat-map)
(put 'next-buffer 'repeat-map '+editor-buffer-repeat-map)

(put '+editor/move-text-up 'repeat-map '+editor-move-text-repeat-map)
(put '+editor/move-text-down 'repeat-map '+editor-move-text-repeat-map)

(setq uniquify-buffer-name-style 'forward
      uniquify-separator "/"
      uniquify-after-kill-buffer-p t)

(map! "C-z"            nil
      "C-<wheel-up>"   nil
      "C-<wheel-down>" nil
      "C-s"            #'save-buffer
      "C-!"            #'list-processes
      "C-c \\"         #'just-one-space
      "C-x 9"          #'+editor/delete-single-window
      "C-."            #'embark-act
      "M-<up>"         #'+editor/move-text-up
      "M-<down>"       #'+editor/move-text-down
      :m "gC" #'capitalize-dwim
      "M-s-="          #'toggle-frame-maximized
      "C-x >"          #'scroll-left
      "C-x <"          #'scroll-right
      [wheel-right]    #'scroll-left
      [wheel-left]     #'scroll-right
      (:when (featurep :system 'linux)
        "s-s"           #'save-buffer))

(map! :leader
      :desc "Expand region"
      "+" #'er/expand-region
      :desc "List processes"
      "!" #'list-processes
      "x" nil
      (:prefix ("x" . "current-window")
       :desc "Delete this window"
       "0" #'delete-window
       :desc "Delete other windows"
       "1" #'delete-other-windows
       :desc "Split window below"
       "2" #'split-window-below
       :desc "Split window right"
       "3" #'split-window-right
       :desc "Delete window and buffer"
       "9" #'+editor/delete-single-window
       :desc "Switch to other window"
       "o" #'ace-window
       :desc "Select entire buffer"
       "h" #'mark-whole-buffer)
      (:prefix ("r" . "region")
       :desc "Move region up"
       "k" #'+editor/move-text-up
       :desc "Move region down"
       "j" #'+editor/move-text-down))

(map! (:map custom-mode-map
            "C-s"           #'Custom-save)
      (:map custom-new-theme-mode-map
            "C-s"           #'custom-theme-save)
      (:map custom-theme-choose-mode-map
            "C-s"           #'custom-theme-save))

(after! flyspell
  (map! (:map flyspell-mode-map
              "C-." nil)))      ; flyspell-auto-correct-word

(use-package! ialign
  :commands (ialign))

(use-package! rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(after! dired
  (remove-hook! 'dired-mode-hook #'dired-omit-mode))

(after! flycheck
  (setq flycheck-emacs-lisp-load-path 'inherit)
  (map! :localleader (:map flycheck-mode-map
                           :desc "List errors"
                           "!" #'consult-flycheck)))

(after! yasnippet
  (setq yas-indent-line 'fixed))

(after! which-key
  (setq which-key-separator ": "))

(after! lispyville
  (lispyville-set-key-theme
   '((operators normal)
     c-w
     (prettify insert)
     (atom-movement t)
     slurp/barf-lispy
     commentary
     wrap
     additional
     additional-insert
     (additional-movement normal visual motion))))

(after! calculator
  (defadvice! +calculator-shrink-window-a (&rest _)
    :after #'calculator
    (set-window-text-height nil 1)))

(after! tramp
  ;; File paths like `/sshx:user@remotehost|sudo:remotehost:/etc/dhcpd.conf`
  ;; will open remote files over multiple hops.
  (setq
   ;; tramp-debug-buffer t
   ;; tramp-verbose 9
   tramp-default-method "scpx"))

(after! vertico
  (setq vertico-count 10)
  (use-package! vertico-mouse
    :config
    (vertico-mouse-mode t)))

(after! lsp-mode
  (setq lsp-eldoc-enable-hover nil
        lsp-ui-doc-enable nil
        lsp-ui-sideline-enable nil
        lsp-modeline-diagnostics-enable nil))

(use-package! mise
  :when (executable-find "mise")
  :config
  (add-hook! 'doom-init-ui-hook #'global-mise-mode))

(after! ghostel
  (setq ghostel-max-scrollback (* 20 1024 1024)))
