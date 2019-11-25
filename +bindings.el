;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

(map! "C-z"           nil               ; suspend-frame
      "C-;"           nil               ; company-manual-begin
      "C-S-s"         nil               ; swiper-helm
      "<escape>"      #'god-local-mode
      "S-<escape>"    #'god-mode-all
      "C-s"           #'save-buffer
      "C-w"           #'+editor/kill-region-or-line
      "C-%"           #'+editor/match-paren
      "C--"           #'pop-tag-mark
      "C-+"           #'er/contract-region
      "C-<"           #'mc/mark-previous-like-this
      "C->"           #'mc/mark-next-like-this
      "C-<f2>"        #'helm-imenu
      "C-c \\"        #'just-one-space
      "C-x C-0"       #'delete-window
      "C-x C-1"       #'delete-other-windows
      "C-x C-2"       #'split-window-below
      "C-x C-3"       #'split-window-right
      "C-x 9"         #'+editor/delete-single-window
      "C-x C-9"       #'+editor/delete-single-window
      "C-x C-j"       #'dired-jump
      "C-x C-."       #'+neotree/open
      "M-<up>"        #'+editor/move-text-up
      "M-<down>"      #'+editor/move-text-down
      "M-i"           #'god-local-mode
      "M-w"           #'+editor/kill-ring-save-region-or-line
      "M-SPC"         #'company-manual-begin
      "M-]"           #'helm-swoop
      "M-."           #'+lookup/definition
      "<f12>"         #'+lookup/definition
      (:prefix ("C-c s" . "hide/show")
        "s"           #'hs-show-block
        "S"           #'hs-show-all
        "D"           #'hs-hide-all
        "d"           #'hs-hide-block)
      (:prefix "M-s"
        "i"           #'helm-occur
        "M-i"         #'helm-occur
        "s"           #'isearch-forward
        "M-s"         #'isearch-forward
        "r"           #'isearch-backward
        "M-r"         #'isearch-backward
        "a"           #'+helm/ag
        "M-a"         #'+helm/ag
        "f"           #'+helm/rg
        "M-f"         #'+helm/rg
        "g"           #'+helm/grep
        "M-g"         #'+helm/grep
        "]"           #'helm-swoop
        "M-]"         #'helm-swoop)
      (:prefix "C-:"
        ":"           #'magit-status
        "C-:"         #'magit-status
        "="           #'vc-ediff
        "C-="         #'vc-ediff
        "f"           #'helm-ls-git-ls
        "C-f"         #'helm-ls-git-ls
        "d"           #'vc-diff
        "C-d"         #'vc-diff
        "c d"         #'magit-diff-working-tree
        "C-c C-d"     #'magit-diff-working-tree
        "l"           #'magit-log-current
        "C-l"         #'magit-log-current)
      (:map custom-mode-map
        "C-s"         #'Custom-save)
      (:map custom-new-theme-mode-map
        "C-s"         #'custom-theme-save)
      (:map custom-theme-choose-mode-map
        "C-s"         #'custom-theme-save)
      (:map god-local-mode-map
        "."           #'repeat
        "z"           #'repeat
        "i"           #'god-local-mode)
      (:map helm-map
        "<tab>"       #'helm-execute-persistent-action
        "C-i"         #'helm-select-action)
      (:map isearch-mode-map
        "<f3>"        #'isearch-repeat-forward
        "S-<f3>"      #'isearch-repeat-backward)
      (:map lispy-mode-map
        "C-:"         nil               ; lispy-colon
        "C-<left>"    nil               ; lispy-forward-barf-sexp
        "C-<right>"   nil               ; lispy-forward-slurp-sexp
        "M-s"         nil               ; lispy-splice
        "M-<up>"      nil               ; lispy-splice-sexp-killing-backward
        "M-<down>"    nil               ; lispy-splice-sexp-killing-forward
        "C-, k"       #'lispy-splice-sexp-killing-forward
        "C-, C-k"     #'lispy-splice-sexp-killing-forward
        "M-S-<down>"  #'lispy-splice-sexp-killing-forward
        "C-, , k"     #'lispy-splice-sexp-killing-backward
        "C-, C-, C-k" #'lispy-splice-sexp-killing-backward
        "M-S-<up>"    #'lispy-splice-sexp-killing-backward
        "C-, f"       #'lispy-forward-slurp-sexp
        "C-, C-f"     #'lispy-forward-slurp-sexp
        "C-, , f"     #'lispy-backward-barf-sexp
        "C-, C-, C-f" #'lispy-backward-barf-sexp
        "C-, b"       #'lispy-forward-barf-sexp
        "C-, C-b"     #'lispy-forward-barf-sexp
        "C-, , b"     #'lispy-backward-slurp-sexp
        "C-, C-, C-b" #'lispy-backward-slurp-sexp
        "C-, s"       #'lispy-splice
        "C-, C-s"     #'lispy-splice)
      (:map org-mode-map
        "C-c n"       #'org-agenda
        "C-x C-e"     #'+org/recalculate-all)
      (:map (common-lisp-mode-map
             emacs-lisp-mode-map
             scheme-mode-map
             racket-mode-map
             hy-mode-map
             lfe-mode-map
             clojure-mode-map)
        "C-c ["       #'highlight-sexp-mode))

(after! smartparens
  (map! (:map smartparens-mode-map
          "C-<right>"   nil             ; sp-forward-slurp-sexp
          "M-<right>"   nil             ; sp-forward-barf-sexp
          "C-<left>"    nil             ; sp-backward-slurp-sexp
          "M-<left>"    nil             ; sp-backward-barf-sexp
          "C-M-d"       nil             ; sp-splice-sexp
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
          "C-:" nil)))
