;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

(put 'previous-buffer 'repeat-map '+bindings-buffer-repeat-map)
(put 'next-buffer 'repeat-map '+bindings-buffer-repeat-map)

(put '+editor/move-text-up 'repeat-map '+bindings-editor-move-text-repeat-map)
(put '+editor/move-text-down 'repeat-map '+bindings-editor-move-text-repeat-map)

(map! "C-z"            nil
      "C-<wheel-up>"   nil
      "C-<wheel-down>" nil
      "C-s"            #'save-buffer
      "C-<"            #'mc/mark-previous-like-this
      "C->"            #'mc/mark-next-like-this
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
        "s-s"           #'save-buffer)
      (:map magit-status-mode-map
            "M-j" #'magit-status-jump)
      (:map custom-mode-map
            "C-s"           #'Custom-save)
      (:map custom-new-theme-mode-map
            "C-s"           #'custom-theme-save)
      (:map custom-theme-choose-mode-map
            "C-s"           #'custom-theme-save)
      (:map org-mode-map
            (:localleader (:prefix-map "b"
                                       "x" #'+org/eval-and-replace
                                       "+" #'+org/insert-parens-and-add
                                       (:prefix-map ("l" . "cell")
                                                    "h" #'org-table-move-cell-left
                                                    "j" #'org-table-move-cell-down
                                                    "k" #'org-table-move-cell-up
                                                    "l" #'org-table-move-cell-right))
                          (:prefix-map ("w" . "gcal")
                                       "w" #'org-gcal-sync
                                       "p" #'org-gcal-post-at-point
                                       "d" #'org-gcal-delete-at-point)
                          (:prefix-map (";" . "brain")
                                       ";" #'org-brain-goto
                                       ":" #'org-brain-visualize
                                       "/" #'org-brain-switch-brain))
            "C-x C-e"       #'+org/eval-and-replace)
      (:map org-agenda-mode-map
            "C-s"           #'org-save-all-org-buffers
            "s-s"           #'org-save-all-org-buffers)
      (:map org-brain-visualize-mode-map
            "L"             #'+org-brain/cliplink-resource))

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
       "j" #'+editor/move-text-down)
      (:prefix ("P" . "password-store")
       :desc "Copy secret"
       "w" #'+pass/copy-secret-to-kill-ring
       :desc "Copy username"
       "b" #'+pass/copy-username-to-kill-ring
       :desc "Copy URL"
       "u" #'+pass/copy-url-to-kill-ring
       :desc "Open URL"
       "U" #'+pass/open-url))

(map! :localleader
      (:map (common-lisp-mode-map
             emacs-lisp-mode-map
             scheme-mode-map
             racket-mode-map
             hy-mode-map
             lfe-mode-map
             clojure-mode-map)
            "[" #'highlight-sexp-mode))

(after! flyspell
  (map! (:map flyspell-mode-map
              "C-." nil)))      ; flyspell-auto-correct-word

(after! ediff
  (advice-add
   'ediff-setup-keymap :after
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
              "]" #'lispy-close-square
              "M-r" #'lispy-raise-sexp
              "M-}" #'lispy-splice-sexp-killing-backward
              "M-]" #'lispy-splice-sexp-killing-forward)
        (:map lispy-mode-map-special
              "p" nil)))

(after! clojure-mode
  (map! (:localleader
         (:map (clojure-mode-map clojurescript-mode-map clojurec-mode-map)
               "f" 'clojure-refactor-map))))

(after! clj-refactor
  (map! (:map clj-refactor-map
              "/" nil)))        ; cljr-slash

(after! flycheck
  (map! :localleader (:map flycheck-mode-map
                           "!" #'consult-flycheck)))

(after! code-review
  (map! (:map code-review-mode-map
              "A" #'+vc-approve-with-feedback)))
