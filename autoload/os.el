;;; ~/.doom.d/autoload/os.el -*- lexical-binding: t; -*-

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
  (if-let* ((url (+pass-get-field entry +pass-user-fields)))
      (password-store--save-field-in-kill-ring entry url "username")
    (error "URL not found.")))

;;;###autoload
(defalias '+pass/copy-secret-to-kill-ring 'password-store-copy)

;;;###autoload
(defalias '+pass/open-url 'password-store-url)

;;;###autoload
(defun +vterm-font-setup ()
  "Applies ASCII replacements specifically for vterm and claude-code."
  (let ((tbl (or buffer-display-table (setq buffer-display-table (make-display-table)))))
    (dolist (pair
             '((#x273B . ?*)            ; ✻ TEARDROP-SPOKED ASTERISK
               (#x273D . ?*)            ; ✽ HEAVY TEARDROP-SPOKED ASTERISK
               (#x2722 . ?+)            ; ✢ FOUR TEARDROP-SPOKED ASTERISK
               (#x2736 . ?+)            ; ✶ SIX-POINTED BLACK STAR
               (#x2733 . ?*)            ; ✳ EIGHT SPOKED ASTERISK
               ))
      (aset tbl (car pair) (vector (cdr pair))))))
