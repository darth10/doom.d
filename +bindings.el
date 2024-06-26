;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

(put 'previous-buffer 'repeat-map '+bindings-buffer-repeat-map)
(put 'next-buffer 'repeat-map '+bindings-buffer-repeat-map)

(put '+editor/move-text-up 'repeat-map '+bindings-editor-move-text-repeat-map)
(put '+editor/move-text-down 'repeat-map '+bindings-editor-move-text-repeat-map)

(map! "C-z"            nil              ; suspend-frame
      "C-;"            nil              ; company-manual-begin
      "C-<wheel-up>"   nil
      "C-<wheel-down>" nil
      "<escape>"       #'god-local-mode
      "S-<escape>"     #'god-mode-all
      "C-s"            #'save-buffer
      "C-w"            #'+editor/kill-region-or-line
      "C-%"            #'+editor/match-paren
      "C-+"            #'er/contract-region
      "C-<"            #'mc/mark-previous-like-this
      "C->"            #'mc/mark-next-like-this
      "C-<f2>"         #'consult-imenu
      "C-!"            #'list-processes
      "C-c \\"         #'just-one-space
      "C-x C-0"        #'delete-window
      "C-x C-1"        #'delete-other-windows
      "C-x C-2"        #'split-window-below
      "C-x C-3"        #'split-window-right
      "C-x 9"          #'+editor/delete-single-window
      "C-x C-9"        #'+editor/delete-single-window
      "C-."            #'embark-act
      "M-<up>"         #'+editor/move-text-up
      "M-p"            #'+editor/move-text-up
      "M-<down>"       #'+editor/move-text-down
      "M-n"            #'+editor/move-text-down
      "M-i"            #'god-local-mode
      "M-c"            #'capitalize-dwim
      "M-l"            #'downcase-dwim
      "M-u"            #'upcase-dwim
      "M-w"            #'+editor/kill-ring-save-region-or-line
      "M-SPC"          #'company-manual-begin
      "M-]"            #'swiper-thing-at-point
      "M-."            #'+lookup/definition
      "<f12>"          #'+lookup/definition
      "M-s-="          #'toggle-frame-maximized
      "C-x >"          #'scroll-left
      "C-x <"          #'scroll-right
      [wheel-right]    #'scroll-left
      [wheel-left]     #'scroll-right
      (:when (featurep :system 'linux)
       "s-s"           #'save-buffer)
      (:prefix ("C-c s" . "hide/show")
       "s"             #'hs-show-block
       "S"             #'hs-show-all
       "D"             #'hs-hide-all
       "d"             #'hs-hide-block)
      (:prefix "M-s"
       "i"             #'consult-multi-occur
       "M-i"           #'consult-multi-occur
       "s"             #'isearch-forward
       "M-s"           #'isearch-forward
       "r"             #'isearch-backward
       "M-r"           #'isearch-backward
       "a"             #'+default/search-project-for-symbol-at-point
       "M-a"           #'+default/search-project-for-symbol-at-point
       "f"             #'+default/search-project-for-symbol-at-point
       "M-f"           #'+default/search-project-for-symbol-at-point
       "]"             #'swiper-thing-at-point
       "M-]"           #'swiper-thing-at-point)
      (:prefix "C-:"
       ":"             #'magit-status
       "C-:"           #'magit-status
       "="             #'vc-ediff
       "C-="           #'vc-ediff
       "b"             #'magit-blame
       "C-b"           #'magit-blame
       "f"             #'projectile-find-file
       "C-f"           #'projectile-find-file
       "d"             #'vc-diff
       "C-d"           #'vc-diff
       "c d"           #'magit-diff-working-tree
       "C-c C-d"       #'magit-diff-working-tree
       "l"             #'magit-log-current
       "C-l"           #'magit-log-current
       "t"             #'magit-todos-list
       "C-t"           #'magit-todos-list)
      (:prefix "C-x P"
       "w" #'+pass/copy-secret-to-kill-ring
       "b" #'+pass/copy-username-to-kill-ring
       "u" #'+pass/copy-url-to-kill-ring
       "U" #'+pass/open-url)
      (:map custom-mode-map
       "C-s"           #'Custom-save)
      (:map custom-new-theme-mode-map
       "C-s"           #'custom-theme-save)
      (:map custom-theme-choose-mode-map
       "C-s"           #'custom-theme-save)
      (:map god-local-mode-map
       "."             #'repeat
       "z"             #'repeat
       "i"             #'god-local-mode)
      (:map isearch-mode-map
       "<f3>"          #'isearch-repeat-forward
       "S-<f3>"        #'isearch-repeat-backward)
      (:map lispy-mode-map-paredit
       "C-:"           nil              ; lispy-colon
       "C-<left>"      nil              ; lispy-forward-barf-sexp
       "C-<right>"     nil              ; lispy-forward-slurp-sexp
       "C-j"           nil              ; lispy-newline-and-indent
       "RET"           nil              ; lispy-newline-and-indent
       "M-s"           nil              ; lispy-splice
       "M-<up>"        nil              ; lispy-splice-sexp-killing-backward
       "M-<down>"      nil              ; lispy-splice-sexp-killing-forward
       "M-."           nil              ; lispy-goto-symbol
       "C-, k"         #'lispy-splice-sexp-killing-forward
       "C-, C-k"       #'lispy-splice-sexp-killing-forward
       "M-S-<down>"    #'lispy-splice-sexp-killing-forward
       "C-, , k"       #'lispy-splice-sexp-killing-backward
       "C-, C-, C-k"   #'lispy-splice-sexp-killing-backward
       "M-S-<up>"      #'lispy-splice-sexp-killing-backward
       "C-, f"         #'lispy-forward-slurp-sexp
       "C-, C-f"       #'lispy-forward-slurp-sexp
       "C-, , f"       #'lispy-backward-barf-sexp
       "C-, C-, C-f"   #'lispy-backward-barf-sexp
       "C-, b"         #'lispy-forward-barf-sexp
       "C-, C-b"       #'lispy-forward-barf-sexp
       "C-, , b"       #'lispy-backward-slurp-sexp
       "C-, C-, C-b"   #'lispy-backward-slurp-sexp
       "C-, s"         #'lispy-splice
       "C-, C-s"       #'lispy-splice
       "C-, l"         #'lispy-oneline
       "C-, C-l"       #'lispy-oneline
       "C-, , l"       #'lispy-multiline
       "C-, C-, C-l"   #'lispy-multiline)
      (:map org-mode-map
       "C-x C-e"       #'+org/eval-and-replace
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
       (:leader "a" nil))               ; embark-act
      (:map org-agenda-mode-map
       "C-s"           #'org-save-all-org-buffers)
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
       "C-c ["         #'highlight-sexp-mode)
      (:map csharp-mode-map
       "C-c C-r"       #'omnisharp-run-code-action-refactoring)
      (:map gnuplot-mode-map
       "C-c C-k"       #'gnuplot-send-buffer-to-gnuplot)
      (:map cider-mode-map
       "M-."           nil)             ; cider-find-var
      (:map lsp-mode-map
       "C-c l f"       #'+lsp-format-buffer-or-region
       "C-c l F"       #'lsp-format-buffer))

(after! smartparens
  (map! (:map smartparens-mode-map
         "C-<right>"   nil              ; sp-forward-slurp-sexp
         "M-<right>"   nil              ; sp-forward-barf-sexp
         "C-<left>"    nil              ; sp-backward-slurp-sexp
         "M-<left>"    nil              ; sp-backward-barf-sexp
         "C-M-d"       nil              ; sp-splice-sexp
         "C-, f"       #'sp-forward-slurp-sexp
         "C-, C-f"     #'sp-forward-slurp-sexp
         "C-, , f"     #'sp-backward-barf-sexp
         "C-, C-, C-f" #'sp-backward-barf-sexp
         "C-, b"       #'sp-forward-barf-sexp
         "C-, C-b"     #'sp-forward-barf-sexp
         "C-, , b"     #'sp-backward-slurp-sexp
         "C-, C-, C-b" #'sp-backward-slurp-sexp
         "C-, s"       #'sp-splice-sexp
         "C-, C-s"     #'sp-splice-sexp)))

(after! flyspell
  (map! (:map flyspell-mode-map
              ; flyspell-auto-correct-word
              "C-." nil)))

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

(after! clojure-mode
  (map! (:map clojure-mode-map
         "C-:" nil)
        (:map clojurescript-mode-map
         "C-c l b" #'+clojurescript-run-cljsbuild)))

(after! clj-refactor
  (cljr-add-keybindings-with-prefix "C-c c :")
  (map! (:map clj-refactor-map
         ; cljr-slash
         "/" nil)))

(after! flycheck
  (put 'flycheck-previous-error 'repeat-map '+bindings-flycheck-errors-repeat-map)
  (put 'flycheck-next-error 'repeat-map '+bindings-flycheck-errors-repeat-map)
  (map! (:map flycheck-mode-map
         "M-g M-p" #'flycheck-previous-error
         "M-g M-n" #'flycheck-next-error)))

(after! code-review
  (map! (:map code-review-mode-map
         "A" #'+vc-approve-with-feedback)))

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
