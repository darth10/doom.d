;;; ~/.doom.d/+org.el -*- lexical-binding: t; -*-

;;; Org

(after! org
  (remove-hook! 'org-mode-hook #'org-bullets-mode)
  (add-hook! 'org-mode-hook #'org-toggle-inline-images)
  (setq org-modules '(ol-bibtex org-habit)
        org-startup-indented nil
        org-eldoc-breadcrumb-separator " > "
        org-clock-heading-function (λ! "")
        org-directory "~/Cloud/org"
        org-log-into-drawer t
        org-log-done t
        org-id-locations-file-relative t   ;; Required for org-brain
        org-attach-id-dir (expand-file-name "attachments/" org-directory)
        org-id-locations-file (expand-file-name ".org-ids" doom-cache-dir)
        org-brain-data-file (expand-file-name ".org-brain.el" doom-cache-dir))
  (set-popup-rule! "^\\*Org Agenda" :side 'bottom :size 0.5 :select t :ttl nil)
  (+org-agenda--load-files org-directory)

  (after! plantuml-mode
    (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
    (add-to-list 'org-src-lang-modes '("plantuml" . plantuml)))

  (use-package! org-gcal
    :init (setq org-gcal-remove-api-cancelled-events t
                ;; Set client ID and secret to stub values to avoid warning on `(require 'org-gcal)`
                org-gcal-client-id "stub-client-id"
                org-gcal-client-secret "stub-client-secret"
                ;; Ensure that `allow-loopback-pinentry' is added to `~/.gnupg/gpg-agent.conf'.
                epg-pinentry-mode 'loopback
                plstore-cache-passphrase-for-symmetric-encryption t)
    :commands (org-gcal-sync org-gcal-post-at-point org-gcal-delete-at-point)
    :config
    (advice-add 'org-gcal-sync :before #'+org-gcal--load)
    (advice-add 'org-gcal-post-at-point :before #'+org-gcal--load)
    (advice-add 'org-gcal-delete-at-point :before #'+org-gcal--load)

    (advice-add 'org-gcal-sync :after #'org-id-update-id-locations)
    (advice-add 'org-gcal-post-at-point :after #'org-id-update-id-locations)
    (advice-add 'org-gcal-delete-at-point :after #'org-id-update-id-locations)))

(use-package! org-brain
  :defer t
  :init
  (setq org-brain-visualize-default-choices 'all
        org-brain-title-max-length 24
        org-brain-include-file-entries nil
        org-brain-file-entries-use-title nil)
  :config
  (set-popup-rule! "^\\*org-brain" :side 'bottom :size 0.5 :select t :ttl nil)
  (defadvice! +org-brain-entry-data (entry)
    "Run `org-element-parse-buffer' on ENTRY text.
Sets `tab-width' in the used temporary buffer, as
`org-current-text-column' expects it to be 8.

If this override is not used, `org-brain-visualize' will crash on
opening an org entry with a list."
    :override #'org-brain-entry-data
    (with-temp-buffer
      (setq-local tab-width 8)
      (insert (org-brain-text entry t))
      (org-element-parse-buffer)))

  (cl-pushnew '("b" "Brain" plain (function org-brain-goto-end)
                "* %i%?" :empty-lines 1)
              org-capture-templates
              :key #'car :test #'equal)

  (when (modulep! :editor evil +everywhere)
    (set-evil-initial-state!
      '(org-brain-visualize-mode
        org-brain-select-map
        org-brain-move-map
        org-brain-polymode-map)
      'normal)
    (defun +org--evilify-map (map)
      (let (keys)
        (map-keymap (lambda (event function)
                      (push function keys)
                      (push (vector event) keys))
                    map)
        (apply #'evil-define-key* 'normal map keys)))

    (+org--evilify-map org-brain-visualize-mode-map)
    (+org--evilify-map org-brain-select-map)
    (+org--evilify-map org-brain-move-map)
    (after! polymode
      (+org--evilify-map org-brain-polymode-map))))

(after! flycheck
  (setq flycheck-global-modes '(not org-mode)))

(after! org-pomodoro
  (setq org-pomodoro-format "~%s")
  (defadvice! +org-pomodoro-update-mode-line-a ()
    "Set the modeline accordingly to the current `org-pomodoro' state."
    :override #'org-pomodoro-update-mode-line
    (let ((s (cl-case org-pomodoro-state
               (:pomodoro
                (propertize org-pomodoro-format 'face 'org-pomodoro-mode-line))
               (:overtime
                (propertize org-pomodoro-overtime-format
                            'face 'org-pomodoro-mode-line-overtime))
               (:short-break
                (propertize org-pomodoro-short-break-format
                            'face 'org-pomodoro-mode-line-break))
               (:long-break
                (propertize org-pomodoro-long-break-format
                            'face 'org-pomodoro-mode-line-break)))))
      (setq org-pomodoro-mode-line
            (when (and (org-pomodoro-active-p) (> (length s) 0))
              (list " [" (format s (org-pomodoro-format-seconds)) "]"))))
    (force-mode-line-update t)))

(after! org-download
  (setq! org-download-screenshot-method
         (cond ((featurep :system 'macos) "screencapture -i %s")
               (t "flameshot gui --raw > %s"))))

(after! lispy
  (add-to-list 'lispy-eval-alist '(org-mode elisp-mode lispy--eval-elisp)))
