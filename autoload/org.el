;;; ~/.doom.d/autoload/org.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +org/recalculate-all ()
  "Recalculate the current table line by applying all stored formulas
until it no longer changes."
  (interactive)
  (when (org-at-table-p)
    (org-table-recalculate 'iterate)))

;;;###autoload
(defun +org-gcal/load ()
  "Load client ID, secret and email from `auth-sources'."
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
                                   :max 1 :create '(id gmail))))
         (client-id     (plist-get auth-plist :id))
         (client-gmail  (plist-get auth-plist :gmail))
         (client-secret (plist-get auth-plist :secret))
         (save-function (plist-get auth-plist :save-function)))
    ;; Set `org-gcal-client-id', `org-gcal-file-alist',
    ;; and `org-gcal-client-secret'.
    (if client-id
        (setq org-gcal-client-id client-id)
      (error "Malformed Google API client ID."))
    (if client-gmail
        (setq org-gcal-file-alist
              ;; TODO change location
              (list (cons client-gmail "~/org/google.org")))
      (error "Malformed Google Mail address."))
    (if (functionp client-secret)
        (setq org-gcal-client-secret (funcall client-secret))
      (error "Malformed Google API client secret."))
    ;; Save to `auth-sources'. This is required on creating token.
    (when (functionp save-function)
      (funcall save-function))))
