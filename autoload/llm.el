;;; autoload/llm.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +gptel-anthropic-key ()
  (let* ((claude-host "platform.claude.com")
         (auth-sources '("~/.authinfo.gpg"))
         (auth-source-creation-prompts
          '((secret . "Enter API key: ")))
         (auth-plist
          (car (auth-source-search :host claude-host
                                   :user (user-login-name)
                                   :max 1 :create t)))
         (api-key (if-let* ((secret (plist-get auth-plist :secret)))
                      (if (functionp secret) (funcall secret) secret)
                    (error "No API key found"))))
    (when-let* ((save-function (plist-get auth-plist :save-function))
                ((functionp save-function)))
      (funcall save-function))
    api-key))
