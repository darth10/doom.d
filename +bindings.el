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
      "C-c s s"       #'hs-show-block
      "C-c C-s C-s"   #'hs-show-block
      "C-c s S"       #'hs-show-all
      "C-c C-s C-S"   #'hs-show-all
      "C-c s d"       #'hs-hide-block
      "C-c C-s C-d"   #'hs-hide-block
      "C-c s D"       #'hs-hide-all
      "C-c C-s C-D"   #'hs-hide-all
      "C-c \\"        #'just-one-space
      "C-x C-0"       #'delete-window
      "C-x C-1"       #'delete-other-windows
      "C-x C-2"       #'split-window-below
      "C-x C-3"       #'split-window-right
      "C-x 9"         #'+editor/delete-single-window
      "C-x C-9"       #'+editor/delete-single-window
      "C-x C-j"       #'dired-jump
      "C-x C-."       #'neotree
      "M-<up>"        #'+editor/move-text-up
      "M-<down>"      #'+editor/move-text-down
      "M-i"           #'god-local-mode
      "M-w"           #'+editor/kill-ring-save-region-or-line
      "M-SPC"         #'company-manual-begin
      "M-]"           #'helm-swoop
      "M-."           #'xref-find-definitions
      "<f12>"         #'xref-find-definitions
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
        "f"           #'helm-ls-git-ls
        "C-f"         #'helm-ls-git-ls)
      (:map custom-mode-map
        "C-s" #'Custom-save)
      (:map custom-new-theme-mode-map
        "C-s" #'custom-theme-save)
      (:map custom-theme-choose-mode-map
        "C-s" #'custom-theme-save)
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
        "<f12>"       #'lispy-goto-symbol
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
        "C-x C-e"     #'+org/recalculate-all))

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
