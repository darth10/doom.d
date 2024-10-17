;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

(put 'previous-buffer 'repeat-map '+bindings-buffer-repeat-map)
(put 'next-buffer 'repeat-map '+bindings-buffer-repeat-map)

;; (put '+editor/move-text-up 'repeat-map '+bindings-editor-move-text-repeat-map)
;; (put '+editor/move-text-down 'repeat-map '+bindings-editor-move-text-repeat-map)

(map! "C-z"            nil  ; suspend-frame
      "C-<wheel-up>"   nil
      "C-<wheel-down>" nil
      "C-s"            #'save-buffer
      "C-<"            #'mc/mark-previous-like-this
      "C->"            #'mc/mark-next-like-this
      "C-!"            #'list-processes
      "C-c \\"         #'just-one-space
      "C-x 9"          #'+editor/delete-single-window
      "C-."            #'embark-act
      ;; TODO <leader> r j/k/up/down
      "M-<up>"         #'+editor/move-text-up
      ;; "M-p"            #'+editor/move-text-up
      "M-<down>"       #'+editor/move-text-down
      ;; "M-n"            #'+editor/move-text-down
      :m "gC" #'capitalize-dwim
      ;; TODO ? company
      ;; "M-SPC"          #'company-manual-begin
      "M-s-="          #'toggle-frame-maximized
      "C-x >"          #'scroll-left
      "C-x <"          #'scroll-right
      [wheel-right]    #'scroll-left
      [wheel-left]     #'scroll-right
      (:when (featurep :system 'linux)
        "s-s"           #'save-buffer)
      (:map magit-status-mode-map
            "M-j" #'magit-status-jump)
      (:map custom-mode-map
            "C-s"           #'Custom-save)
      (:map custom-new-theme-mode-map
            "C-s"           #'custom-theme-save)
      (:map custom-theme-choose-mode-map
            "C-s"           #'custom-theme-save)
      (:map lispy-mode-map-lispy
            ;; TODO should be <leader> [/]
            "M-[" #'lispy-splice-sexp-killing-backward
            "M-]" #'lispy-splice-sexp-killing-forward)
      (:map org-mode-map
            ;; :v "+" #'+org/insert-parens-and-add
            (:localleader (:prefix-map "b"
                                       "x" #'+org/eval-and-replace
                                       "+" #'+org/insert-parens-and-add))
            "C-x C-e"       #'+org/eval-and-replace
            ;; TODO use <leader> o g ... instead of <C-c> g
            ;; TODO use <leader> m b l ... instead of <C-c> l
            "C-c l b x"     #'+org/eval-and-replace
            "C-c l <up>"    #'org-table-move-cell-up
            "C-c l <down>"  #'org-table-move-cell-down
            "C-c l <left>"  #'org-table-move-cell-left
            "C-c l <right>" #'org-table-move-cell-right
            "C-c g g"       #'org-gcal-sync
            "C-c g C-g"     #'org-gcal-sync
            "C-c g p"       #'org-gcal-post-at-point
            "C-c g C-p"     #'org-gcal-post-at-point
            "C-c g d"       #'org-gcal-delete-at-point
            "C-c g C-d"     #'org-gcal-delete-at-point
            (:prefix ("C-c b" . "brain")
                     "c"            #'org-brain-goto
                     "b"            #'org-brain-visualize
                     "/"            #'org-brain-switch-brain)
            (:leader "a" nil))          ; embark-act
      (:map org-agenda-mode-map
            "C-s"           #'org-save-all-org-buffers
            "s-s"           #'org-save-all-org-buffers)
      (:map org-brain-visualize-mode-map
            "L"             #'+org-brain/cliplink-resource)
      (:map (org-mode-map org-brain-visualize-mode-map)
            "C-c a"         #'org-agenda
            (:prefix ("C-c b" . "brain")
                     "a"            #'org-brain-agenda))
      (:map (common-lisp-mode-map
             emacs-lisp-mode-map
             scheme-mode-map
             racket-mode-map
             hy-mode-map
             lfe-mode-map
             clojure-mode-map)
            ;; TODO this should be a hook
            "C-c ["         #'highlight-sexp-mode)
      (:map lsp-mode-map
            "C-c l f"       #'+lsp-format-buffer-or-region
            "C-c l F"       #'lsp-format-buffer))

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
               "9" #'+editor/delete-single-window)
      (:prefix ("P" . "password-store")
               :desc "Copy secret"
               "w" #'+pass/copy-secret-to-kill-ring
               :desc "Copy username"
               "b" #'+pass/copy-username-to-kill-ring
               :desc "Copy URL"
               "u" #'+pass/copy-url-to-kill-ring
               :desc "Open URL"
               "U" #'+pass/open-url))

(after! flyspell
  (map! (:map flyspell-mode-map
              ;; flyspell-auto-correct-word
              "C-." nil)))

(after! ediff
  (advice-add
   'ediff-setup-keymap :after
   ;; TODO
   (λ! (map! (:map ediff-mode-map
              "M-<up>"      #'ediff-previous-difference
              "M-<down>"    #'ediff-next-difference
              "M-<left>"    #'ediff-copy-B-to-A
              "M-<right>"   #'ediff-copy-A-to-B)))))

(after! emmet-mode
  (map! (:map emmet-mode-keymap
         "<tab>" #'emmet-expand-line)))

(after! lispy
  (map! (:map lispy-mode-map-lispy
              "[" #'lispy-open-square
              "]" #'lispy-close-square)
        (:map lispy-mode-map-special
              "p" nil)))

(after! clojure-mode
  (map! (:localleader
         (:map (clojure-mode-map clojurescript-mode-map clojurec-mode-map)
               "f" 'clojure-refactor-map))))

(after! clj-refactor
  ;; TODO
  (cljr-add-keybindings-with-prefix "C-c c :")
  (map! (:map clj-refactor-map
         ; cljr-slash
         "/" nil)))

(after! flycheck
  ;; (put 'flycheck-previous-error 'repeat-map '+bindings-flycheck-errors-repeat-map)
  ;; (put 'flycheck-next-error 'repeat-map '+bindings-flycheck-errors-repeat-map)
  (map! (:map flycheck-mode-map
              ;; TODO
         "M-g M-p" #'flycheck-previous-error
         "M-g M-n" #'flycheck-next-error)))

(after! code-review
  (map! (:map code-review-mode-map
         "A" #'+vc-approve-with-feedback)))

;; TODO are these really needed?
(after! avy
  (map! (:prefix "M-g"
                 "s" #'avy-goto-symbol-1
                 "C-s" #'avy-goto-symbol-1
                 "l" #'avy-goto-line
                 "C-l" #'avy-goto-line
                 "1" #'avy-goto-char
                 "C-1" #'avy-goto-char
                 "2" #'avy-goto-char-2
                 "C-2" #'avy-goto-char-2
                 "p" #'avy-goto-word-1-above
                 "C-p" #'avy-goto-word-1-above
                 "n" #'avy-goto-word-1-below
                 "C-n" #'avy-goto-word-1-below)))

;; TODO are these training wheels?
(after! evil-god-state
  ;; TODO C- not added in god mode
  (map! :leader "v" #'evil-god-state)
  (map! (:map god-local-mode-map
              "i"        #'evil-insert-state
              "<escape>" #'evil-god-state-bail)))
