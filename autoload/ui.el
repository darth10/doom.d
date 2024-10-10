;;; ~/.doom.d/autoload/ui.el -*- lexical-binding: t; -*-

(defconst +ui--scratch-message-help-text
  "To open a file, type C-x C-f.
To quit a partially entered command, type C-g.
To quit Emacs, type C-x C-c.

For information about GNU Emacs and the GNU system, type C-h C-a.")

;;;###autoload
(defun +ui--get-scratch-message ()
  "Get message to show in *scratch* buffer."
  ;; '((t (:inherit font-lock-keyword-face :weight bold)))
  (let* ((face-for-logo 'font-lock-keyword-face)
         (face-for-keys 'font-lock-function-name-face)
         (logo-text (with-temp-buffer
                      (insert-file-contents (expand-file-name "resources/doomemacs.txt" doom-private-dir))
                      (buffer-string)))
         (face-for-comments 'font-lock-comment-delimiter-face)
         (version-text (concat
                        (propertize (format "doom %s"
                                            doom-version)
                                    'face face-for-logo)
                        " / "
                        (propertize (format "GNU Emacs %s"
                                            emacs-version)
                                    'face face-for-logo)))
         (help-text (replace-regexp-in-string
                     ;; Too early to use λ! here.
                     "C-." (lambda (s) (propertize s 'face face-for-keys))
                     (concat +ui--scratch-message-help-text "\n"
                             version-text))))
    (concat
     (replace-regexp-in-string
      "^" (propertize ";; " 'face face-for-comments)
      (propertize (concat logo-text "\n") 'face face-for-logo))
     (replace-regexp-in-string
      "^" (propertize ";; " 'face face-for-comments)
      help-text)
     "\n\n")))

;;;###autoload
(defun +ui--switch-buffer-or-frame-h ()
  (let ((is-pdf-mode (eq major-mode 'pdf-view-mode)))
    ;; Disable cursor in PDFs.
    (blink-cursor-mode (if is-pdf-mode -1 +1))
    (when is-pdf-mode (internal-show-cursor nil nil))))

;;;###autoload
(defvar +ui--hl-line-background "#00212b") ; solaire-hl-line-face background

;;;###autoload
(defvar +ligatures-prog-mode-list
  '("|||>" "<|||" "<==>" "<!--" "~~>" "||=" "||>"
    ":::" "::=" "=:=" "==>" "=>>" "=<<" "=/="
    "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->""-<<"
    "<~~" "<~>"  "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
    "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "..<"
    "..." "/==" "///" "_|_" "^=" "~~" "~="
    "~>" "~-" "|}" "|]" "|=" "|>" "{|"
    "[|" "::" ":=" "$>" "==" "=>" "!="
    ">=" ">>" ">-" "-~" "->" "-<" "<~" "<|"
    "<$" "<=" "<-" "<<" "<+" "</"
    ".=" ".-" ".." ".?" "+>" "?:"
    "?=" "?." "/=" "/>" "//" "__" "~~"))

;;;###autoload
(defvar +ligatures-all-modes-list +ligatures-prog-mode-list)
