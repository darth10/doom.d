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
        org-attach-id-dir (expand-file-name "attachments/" org-directory)
        org-id-locations-file (expand-file-name ".org-ids" doom-cache-dir)
        org-brain-data-file (expand-file-name ".org-brain.el" doom-cache-dir))
  (set-popup-rule! "^\\*Org Agenda" :side 'bottom :size 0.5 :select t :ttl nil)
  (+org-agenda--load-files org-directory)

  (after! plantuml-mode
    (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
    (add-to-list 'org-src-lang-modes '("plantuml" . plantuml)))

  (use-package! org-gcal
    :init (+org-gcal--load)
    :config
    (setq org-gcal-remove-api-cancelled-events t)
    (add-hook! (org-gcal-sync org-gcal-post-at-point org-gcal-delete-at-point)
               #'org-id-update-id-locations)))

(after! org-brain
  (set-popup-rule! "^\\*org-brain" :side 'bottom :size 0.5 :select t :ttl nil))

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
