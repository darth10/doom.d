;;; autoload/os.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +aws-list-profiles ()
  (delete "default"
          (split-string
           (shell-command-to-string "aws configure list-profiles"))))

;;;###autoload
(defun +aws/sso-login ()
  (interactive)
  (let* ((choices (+aws-list-profiles))
         (profile (completing-read "Profile: " choices)))
    (async-shell-command (concat "aws sso login --profile " profile))))

;;;###autoload
(defun +aws/assume-role ()
  (interactive)
  (let* ((choices (+aws-list-profiles))
         (profile (completing-read "Profile: " choices)))
    (async-shell-command (concat "assume-aws " profile))))

;;;###autoload
(defun +pass/copy-url-to-kill-ring (entry)
  "Add URL for ENTRY into the kill ring."
  (interactive
   (list (password-store--completing-read)))
  (if-let* ((url (+pass-get-field entry +pass-url-fields)))
      (password-store--save-field-in-kill-ring entry url "url")
    (error "URL not found.")))

;;;###autoload
(defun +pass/copy-username-to-kill-ring (entry)
  "Add username for ENTRY into the kill ring."
  (interactive
   (list (password-store--completing-read)))
  (if-let* ((username (+pass-get-field entry +pass-user-fields)))
      (password-store--save-field-in-kill-ring entry username "username")
    (error "Username not found.")))

;;;###autoload
(defalias '+pass/copy-secret-to-kill-ring 'password-store-copy)

;;;###autoload
(defalias '+pass/open-url 'password-store-url)

;;;###autoload
(defun +edit-server-start-h ()
  "Start the edit server once a graphical frame exists."
  (when (and (display-graphic-p)
             (not (process-status "edit-server")))
    (edit-server-start)))
