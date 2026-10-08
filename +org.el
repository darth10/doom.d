;;; +org.el -*- lexical-binding: t; -*-

;;; Org

(after! org
  (setq org-modules '(ol-bibtex org-habit)
        org-startup-indented nil
        org-startup-with-link-previews t
        org-eldoc-breadcrumb-separator " > "
        org-clock-heading-function (lambda () "")
        org-directory "~/Cloud/org"
        org-log-into-drawer t
        org-log-done t
        org-attach-id-dir (expand-file-name "attachments/" org-directory)
        org-id-locations-file (expand-file-name ".org-ids" doom-cache-dir)
        org-refile-targets '((nil :maxlevel . 3)
                             (org-roam-list-files :maxlevel . 3)
                             (+roam-agenda--capture-files :maxlevel . 3)))
  (add-to-list 'org-tags-exclude-from-inheritance "agenda")
  (add-hook 'org-mode-hook #'+org-disable-visual-line-mode-h)
  (set-popup-rule! "^\\*Org Agenda" :side 'bottom :size 0.5 :select t :ttl nil)

  (map! (:map org-mode-map
              (:localleader (:prefix "b"
                             :desc "Eval and replace"
                             "x" #'+org/eval-and-replace
                             :desc "Insert parens and add"
                             "+" #'+org/insert-parens-and-add
                             :desc "Recalculate table"
                             "r" #'org-table-recalculate
                             :desc "Credit card entries for month"
                             "n" #'+org/credit-card-matching-entries-for-month
                             (:prefix ("l" . "cell")
                              :desc "Move cell left"
                              "h" #'org-table-move-cell-left
                              :desc "Move cell down"
                              "j" #'org-table-move-cell-down
                              :desc "Move cell up"
                              "k" #'org-table-move-cell-up
                              :desc "Move cell right"
                              "l" #'org-table-move-cell-right)))
              "C-x C-e" #'+org/eval-and-replace))

  (after! plantuml-mode
    (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
    (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))))

(use-package! org-gcal
  :after org
  :init
  (setq org-gcal-remove-api-cancelled-events t
        ;; Set client ID and secret to stub values to avoid warning on `(require 'org-gcal)`
        org-gcal-client-id "stub-client-id"
        org-gcal-client-secret "stub-client-secret"
        ;; Ensure that `allow-loopback-pinentry' is added to `~/.gnupg/gpg-agent.conf'.
        epg-pinentry-mode 'loopback
        plstore-cache-passphrase-for-symmetric-encryption t)
  (map! (:map org-mode-map
              (:localleader (:prefix ("w" . "gcal")
                             :desc "Sync calendars"
                             "w" #'org-gcal-sync
                             :desc "Post event at point"
                             "p" #'org-gcal-post-at-point
                             :desc "Delete event at point"
                             "d" #'org-gcal-delete-at-point))))
  :commands (org-gcal-sync org-gcal-post-at-point org-gcal-delete-at-point)
  :config
  (advice-add 'org-gcal-sync :before #'+org-gcal--load)
  (advice-add 'org-gcal-post-at-point :before #'+org-gcal--load)
  (advice-add 'org-gcal-delete-at-point :before #'+org-gcal--load)

  (advice-add 'org-gcal-sync :after #'org-id-update-id-locations)
  (advice-add 'org-gcal-post-at-point :after #'org-id-update-id-locations)
  (advice-add 'org-gcal-delete-at-point :after #'org-id-update-id-locations))

(after! org-agenda
  (map! (:map org-agenda-mode-map
              "C-s"           #'org-save-all-org-buffers
              "s-s"           #'org-save-all-org-buffers)))

(use-package! org-roam
  :defer t
  :init
  (setq org-roam-directory "~/Cloud/org/brain/")
  (set-file-template! 'org-mode
    :when (lambda (file) (file-in-directory-p file org-roam-directory))
    :ignore t)
  (add-hook 'find-file-hook #'+roam-agenda-update-tag-h)
  (add-hook 'before-save-hook #'+roam-agenda-update-tag-h)
  (dolist (fn '(org-agenda org-agenda-list org-todo-list))
    (advice-add fn :before #'+roam-agenda-files-update-a))
  (dolist (fn '(org-tags-view org-search-view))
    (advice-add fn :around #'+roam-agenda-all-files-a))
  :config
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
           :unnarrowed t))))

(after! flycheck
  (setq flycheck-global-modes '(not org-mode)))

(after! org-pomodoro
  (setq org-pomodoro-format "~%s")
  (defadvice! +org-pomodoro-mode-line-spacing-a ()
    "Put the space before the pomodoro timer instead of after it."
    :after #'org-pomodoro-update-mode-line
    (pcase org-pomodoro-mode-line
      (`("[" ,time "] ")
       (setq org-pomodoro-mode-line (list " [" time "]"))))))

(after! org-download
  (setopt org-download-screenshot-method
          (cond ((featurep :system 'macos) "screencapture -i %s")
                (t "flameshot gui --raw > %s"))))

(after! lispy
  (add-to-list 'lispy-eval-alist '(org-mode elisp-mode lispy--eval-elisp)))
