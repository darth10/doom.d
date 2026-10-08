;;; autoload/roam-agenda.el -*- lexical-binding: t; -*-

(defun +roam-agenda--buffer-p ()
  (and buffer-file-name
       (derived-mode-p 'org-mode)
       (file-in-directory-p buffer-file-name org-roam-directory)))

(defun +roam-agenda--needed-p ()
  "Non-nil if the buffer has a not-done heading that the agenda would show.
That is a heading with a todo keyword, or with an active timestamp (including
SCHEDULED and DEADLINE) in its own section."
  (org-with-wide-buffer
   (seq-some #'identity
             (org-map-entries
              (lambda ()
                (and (not (org-entry-is-done-p))
                     (or (org-entry-is-todo-p)
                         (save-excursion
                           (forward-line)
                           (re-search-forward org-ts-regexp
                                              (save-excursion (outline-next-heading) (point))
                                              t)))))))))

(defun +roam-agenda--filetags ()
  (split-string (or (cadr (assoc "FILETAGS" (org-collect-keywords '("FILETAGS")))) "")
                ":" t))

;;;###autoload
(defun +roam-agenda-update-tag-h ()
  "Add or remove the `agenda' filetag in the current roam buffer."
  (when (and (not (active-minibuffer-window)) (+roam-agenda--buffer-p))
    (let* ((old (+roam-agenda--filetags))
           (new (if (+roam-agenda--needed-p)
                    (seq-uniq (cons "agenda" old))
                  (remove "agenda" old))))
      (unless (seq-set-equal-p old new)
        (if new
            (org-roam-set-keyword "filetags" (concat ":" (string-join new ":") ":"))
          (org-roam-erase-keyword "filetags"))))))

;;;###autoload
(defun +roam-agenda-files ()
  "Return the files in `org-roam-directory' tagged with `agenda'."
  (require 'org-roam)
  (mapcar #'car
          (org-roam-db-query
           [:select :distinct [nodes:file] :from tags
            :left-join nodes :on (= tags:node-id nodes:id)
            :where (= tags:tag "agenda")])))

;;;###autoload
(defun +roam-agenda--capture-files ()
  ;; Doom's capture target for `SPC X t'
  (seq-filter #'file-exists-p
              (list (expand-file-name +org-capture-todo-file org-directory))))

;;;###autoload
(defun +roam-agenda-files-update-a (&rest _)
  (setq org-agenda-files
        (append (+roam-agenda-files) (+roam-agenda--capture-files))))

;;;###autoload
(defun +roam-agenda-all-files-a (fn &rest args)
  "Call FN with `org-agenda-files' bound to every file in `org-roam-directory'.
For tag and text searches, which should not be limited to `agenda' files."
  (require 'org-roam)
  (let ((org-agenda-files (append (org-roam-list-files) (+roam-agenda--capture-files))))
    (apply fn args)))
