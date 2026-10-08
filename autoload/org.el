;;; autoload/org.el -*- lexical-binding: t; -*-

;;;###autoload
(defvar +org-gcal-calendar-id nil)

;;;###autoload
(defvar +org-gcal-org-file-name "Google.org")

;;;###autoload
(defun +org-gcal--load ()
  "Load client ID, secret and email from `auth-sources'."
  (require 'auth-source)
  (let* ((org-gcal-host "www.googleapis.com")
         (auth-sources '("~/.authinfo.gpg"))
         (auth-source-creation-defaults
          '((user  . (user-login-name))
            (id    . (read-string "Enter Google API client ID: "))
            (gmail . (read-string "Enter Google Mail address: "))))
         (auth-source-creation-prompts
          '((secret . "Enter Google API client secret: ")))
         (auth-plist
          (car (auth-source-search :host org-gcal-host
                                   :user (user-login-name)
                                   :max 1 :create '(id gmail)))))
    ;; Set `org-gcal-client-id', `org-gcal-file-alist',
    ;; and `org-gcal-client-secret'.
    (if-let* ((client-id (plist-get auth-plist :id)))
        (setq org-gcal-client-id client-id)
      (error "Malformed Google API client ID."))
    (if-let* ((client-gmail (plist-get auth-plist :gmail)))
        (setq org-gcal-file-alist
              (list (cons client-gmail
                          (expand-file-name +org-gcal-org-file-name org-roam-directory)))
              +org-gcal-calendar-id client-gmail)
      (error "Malformed Google Mail address."))
    (if-let* ((client-secret (plist-get auth-plist :secret))
              ((functionp client-secret)))
        (setq org-gcal-client-secret (funcall client-secret))
      (error "Malformed Google API client secret."))
    ;; Save to `auth-sources'. This is required on creating token.
    (when-let* ((save-function (plist-get auth-plist :save-function))
                ((functionp save-function)))
      (funcall save-function))
    (org-gcal-reload-client-id-secret)))

;;;###autoload
(defun +org/eval-and-replace ()
  "Evaluates and replaces last expression as Emacs Lisp."
  (interactive)
  (require 'lispy)
  (let* ((leftp (lispy--leftp))
         (bnd (lispy--bounds-dwim))
         (str (lispy--string-dwim bnd))
         (res (lispy--eval str)))
    (delete-region (car bnd) (cdr bnd))
    (deactivate-mark)
    (insert res)
    (when (org-at-table-p)
      (org-table-recalculate 'iterate))
    (unless (or (lispy-left-p)
                (lispy-right-p)
                (member major-mode '(python-mode org-mode julia-mode)))
      (lispy--out-backward 1))
    (when (and leftp (lispy-right-p))
      (lispy-different))))

;;;###autoload
(defun +org/insert-parens-and-add ()
  (interactive)
  (when (not (eq 'insert evil-state))
    (evil-insert 0))
  (insert-char ?\()
  (insert-char ?+)
  (just-one-space)
  (forward-word)
  (insert-char ?\s)
  (insert-char ?\))
  (backward-char))

;;;###autoload
(defun +org-disable-visual-line-mode-h ()
  (visual-line-mode -1))

(defun +org--credit-card-table ()
  (save-excursion
    (unless (org-at-table-p)
      (goto-char (point-min))
      (unless (re-search-forward org-table-line-regexp nil t)
        (user-error "No table in this buffer")))
    (org-table-to-lisp)))

(defun +org--credit-card-month-entries (table)
  "Data rows of TABLE as (MONTH . ROW), MONTH being the latest MMM marker above ROW."
  (let ((rows (cdr (memq 'hline table)))
        month acc)
    (while (and rows (not (eq (car rows) 'hline)))
      (let ((row (pop rows)))
        (unless (string-empty-p (car row))
          (setq month (car row)))
        (push (cons month row) acc)))
    (nreverse acc)))

(defun +org--credit-card-matching-entries (regexp month)
  (let ((case-fold-search nil))
    (seq-keep (lambda (entry)
                (and (equal (car entry) month)
                     (string-match-p regexp (nth 4 (cdr entry)))
                     (cdr entry)))
              (+org--credit-card-month-entries (+org--credit-card-table)))))

;;;###autoload
(defun +org/credit-card-matching-entries-for-month (regexp month)
  "Show the current credit card entries for MONTH that match REGEXP."
  (interactive
   (let ((regexp (read-string "Search: " (current-word) 'regexp-history))
         (months (delete-dups (delq nil (mapcar #'car (+org--credit-card-month-entries (+org--credit-card-table)))))))
     (list regexp (completing-read "Month: " months nil t nil nil (car (last months))))))
  (let ((rows (+org--credit-card-matching-entries regexp month)))
    (with-current-buffer (get-buffer-create (format "*Credit card %s: %s*" regexp month))
      (erase-buffer)
      (org-mode)
      (insert "| MMM | - | + | = | R |\n|-\n")
      (insert "| " month " |   |   |   |   |\n")
      (dolist (row rows)
        (insert "| " (string-join row " | ") " |\n"))
      (insert "|-\n| _ | credit | paid | total | |\n| # | | | | |\n")
      (insert "#+TBLFM: $credit=vsum(@2..@-2)::$paid=vsum(@2..@-2)::$total=vsum(@2$2..@-2$2)-vsum(@2$3..@-2$3)")
      (goto-char (point-min))
      (org-table-recalculate t)
      (pop-to-buffer (current-buffer)))))
