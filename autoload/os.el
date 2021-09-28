;;; ~/.doom.d/autoload/os.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +eshell--load-bash-aliases-h ()
  "Reads bash aliases from Bash and inserts
    them into the list of eshell aliases."
  (interactive)
  (progn
    (shell-command "alias" "bash-aliases" "bash-errors")
    (switch-to-buffer "bash-aliases")
    (replace-string "alias " "")
    (goto-char 1)
    (replace-string "='" " ")
    (goto-char 1)
    (replace-string "'\n" "\n")
    (goto-char 1)
    (let ((alias-name) (command-string) (alias-list))
      (while (not (eobp))
        (while (not (char-equal (char-after) 32))
          (forward-char 1))
        (setq alias-name
              (buffer-substring-no-properties (line-beginning-position) (point)))
        (forward-char 1)
        (setq command-string
              (buffer-substring-no-properties (point) (line-end-position)))
        (setq alias-list (cons (list alias-name command-string) alias-list))
        (forward-line 1))
      (setq eshell-command-aliases-list alias-list))
    (if (get-buffer "bash-aliases") (kill-buffer "bash-aliases"))
    (if (get-buffer "bash-errors") (kill-buffer "bash-errors"))
    (message "Loaded aliases.")))

;;;###autoload
(defun +aws-list-profiles ()
  (delete "default"
          (split-string
           (shell-command-to-string "aws configure list-profiles"))))

;;;###autoload
(defun +aws-sso-login ()
  (interactive)
  (let* ((choices (+aws-list-profiles))
         (profile (completing-read "Profile: " choices)))
    (async-shell-command (concat "aws sso login --profile " profile))))

;;;###autoload
(defun +aws-assume-role ()
  (interactive)
  (let* ((choices (+aws-list-profiles))
         (profile (completing-read "Profile: " choices)))
    (async-shell-command (concat "assume-aws " profile))))
