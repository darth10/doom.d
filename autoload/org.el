;;; ~/.doom.d/autoload/org.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +org-brain/cliplink-resource ()
  "Add a URL from the clipboard as an org-brain resource with prompts."
  (interactive)
  (require 'org-cliplink)
  (org-brain-add-resource (org-cliplink-clipboard-content) nil t))

;;;###autoload
(defun +org/recalculate-all ()
  "Recalculate the current table line by applying all stored formulas
until it no longer changes."
  (interactive)
  (when (org-at-table-p)
    (org-table-recalculate 'iterate)))

;;;###autoload
(defvar +org-gcal-calendar-id nil)

;;;###autoload
(defvar +org-gcal-org-file-name "Google.org")

;;;###autoload
(defun +org-gcal--load ()
  "Load client ID, secret and email from `auth-sources'."
  (require 'org-brain)
  (let* ((org-gcal-host "www.googleapis.com")
         (auth-sources '("~/.authinfo.gpg"))
         (auth-source-creation-defaults
          '((user .  (user-login-name))
            (id .    (read-string "Enter Google API client ID: "))
            (gmail . (read-string "Enter Google Mail address: "))))
         (auth-source-creation-prompts
          '((secret . "Enter Google API client secret: ")))
         (auth-plist
          (car (auth-source-search :host org-gcal-host
                                   :user (user-login-name)
                                   :max 1 :create '(id gmail)))))
    ;; Set `org-gcal-client-id', `org-gcal-file-alist',
    ;; and `org-gcal-client-secret'.
    (if-let ((client-id (plist-get auth-plist :id)))
        (setq org-gcal-client-id client-id)
      (error "Malformed Google API client ID."))
    (if-let ((client-gmail (plist-get auth-plist :gmail)))
        (setq org-gcal-file-alist
              (list (cons client-gmail
                          (expand-file-name +org-gcal-org-file-name org-brain-path)))
              +org-gcal-calendar-id client-gmail)
      (error "Malformed Google Mail address."))
    (if-let ((client-secret (plist-get auth-plist :secret))
             (client-secret-p (functionp client-secret)))
        (setq org-gcal-client-secret (funcall client-secret))
      (error "Malformed Google API client secret."))
    ;; Save to `auth-sources'. This is required on creating token.
    (when-let ((save-function (plist-get auth-plist :save-function))
               (save-function-p (functionp save-function)))
      (funcall save-function))))

;;;###autoload
(defun +org-agenda--load-files (dir)
  "Sets `org-agenda-files' to all org files in directory DIR."
  (setq! org-agenda-files (directory-files-recursively dir "\\.org$")))
