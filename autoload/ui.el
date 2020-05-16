;;; ~/.doom.d/autoload/ui.el -*- lexical-binding: t; -*-

(defconst +ui--scratch-message-logo-text
  "
    ____  ____  ____  __  ___   ________  ______   ___________
   / __ \\/ __ \\/ __ \\/  |/  /  / ____/  |/  /   | / ____/ ___/
  / / / / / / / / / / /|_/ /  / __/ / /|_/ / /| |/ /    \\__ \\
 / /_/ / /_/ / /_/ / /  / /  / /___/ /  / / ___ / /___ ___/ /
/_____/\\____/\\____/_/  /_/  /_____/_/  /_/_/  |_\\____//____/

")

(defconst +ui--scratch-message-help-text
  "To open a file, type C-x C-f.
To quit a partially entered command, type C-g.
To quit Emacs, type C-x C-c.

For information about GNU Emacs and the GNU system, type C-h C-a.")

;;;###autoload
(defvar +ui--modeline-mode-string " ")

;;;###autoload
(defun +ui--get-scratch-message ()
  "Get message to show in *scratch* buffer."
  (let* ((face-for-logo 'font-lock-function-name-face)
         (face-for-keys 'font-lock-string-face)
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
      (propertize +ui--scratch-message-logo-text 'face face-for-logo))
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
