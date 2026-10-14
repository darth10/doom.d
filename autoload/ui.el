;;; autoload/ui.el -*- lexical-binding: t; -*-

(defconst +ui--scratch-message-help-text
  "To open a file, type C-x C-f.
To quit a partially entered command, type C-g.
To quit Emacs, type C-x C-c.

For information about GNU Emacs and the GNU system, type C-h C-a.")

;;;###autoload
(defconst +ui-banner-svg-template (expand-file-name "resources/emacs-e.svg" doom-user-dir))

;;;###autoload
(defconst +ui-banner-text-file (expand-file-name "resources/emacs-e.txt" doom-user-dir))

(defvar +ui-dashboard-banner-height 250)

(defvar +ui-dashboard-banner-colours
  '(("$colour1" . font-lock-keyword-face)
    ("$colour2" . default))
  "Colour substitutions for `+ui-banner-svg-template'.
Each entry is (PLACEHOLDER . FACE). For `default', the face background is
used; for all others, the face foreground.")

(defvar +ui-dashboard-banner-file
  (expand-file-name "dashboard-banner.svg" doom-cache-dir))

(defun +ui--hex-colour (colour fallback)
  "Return COLOUR as #rrggbb, or FALLBACK if it isn't a known colour.
Terminal frames can report names like \"unspecified-fg\" that aren't valid in SVG."
  (cond ((and colour (string-prefix-p "#" colour)) colour)
        ((when-let* ((rgb (and colour (color-name-to-rgb colour))))
           (apply #'color-rgb-to-hex (append rgb '(2)))))
        (t fallback)))

(defun +ui--dashboard-banner-svg ()
  (with-temp-buffer
    (insert-file-contents +ui-banner-svg-template)
    (goto-char (point-min))
    (when (search-forward "$height" nil t)
      (replace-match (number-to-string +ui-dashboard-banner-height) nil t))
    (pcase-dolist (`(,placeholder . ,face) +ui-dashboard-banner-colours)
      (goto-char (point-min))
      (let ((colour (if (eq face 'default)
                        (+ui--hex-colour (face-background 'default nil t) "#282c34")
                      (+ui--hex-colour (face-foreground face nil t) "#81a2be"))))
        (while (search-forward placeholder nil t)
          (replace-match colour nil t))))
    (buffer-string)))

;;;###autoload
(defun +ui-dashboard-insert-banner ()
  "Insert the theme-coloured SVG banner, falling back to text in terminal frames.
The buffer is shared by GUI and terminal emacsclient frames, so both banners are
inserted and `dashboard-insert-banner' picks one per frame at redisplay time."
  (make-directory (file-name-directory +ui-dashboard-banner-file) t)
  (with-temp-file +ui-dashboard-banner-file
    (insert (+ui--dashboard-banner-svg)))
  (clear-image-cache +ui-dashboard-banner-file)
  (let ((dashboard-startup-banner (cons +ui-dashboard-banner-file +ui-banner-text-file)))
    (dashboard-insert-banner)))

;;;###autoload
(defun +ui-dashboard-refresh-on-theme-h (&rest _)
  (when (and (display-graphic-p)
             (get-buffer dashboard-buffer-name))
    (save-window-excursion
      (dashboard-open))))

;;;###autoload
(defun +ui--get-scratch-message ()
  "Get message to show in *scratch* buffer."
  ;; '((t (:inherit font-lock-keyword-face :weight bold)))
  (let* ((face-for-logo 'font-lock-keyword-face)
         (face-for-keys 'font-lock-function-name-face)
         (logo-text (with-temp-buffer
                      (insert-file-contents +ui-banner-text-file)
                      (buffer-string)))
         (face-for-comments 'font-lock-comment-delimiter-face)
         (version-text (concat
                        (propertize (format "doom %s"
                                            (doom-version))
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
