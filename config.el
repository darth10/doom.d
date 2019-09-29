;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; TODO move once god module merged

(defcustom holy-emacs-modeline-god-mode-indicator ":"
  "Modeline indicator for `god-mode'."
  :type 'string
  :group 'holy-emacs)

(defcustom holy-emacs-modeline-overwrite-mode-indicator "!"
  "Modeline indicator for `overwrite-mode'."
  :type 'string
  :group 'holy-emacs)

(defconst core--default-fill-column 80
  "Default column limit.")

(use-package! god-mode
  :commands (god-local-mode god-mode-all)
  :hook ((after-init . god-mode-all)
         (overwrite-mode . +god--toggle-on-overwrite))
  :init
  (defun core--configure-mode ()
    "Configure cursor type and color depending on mode."
    (let* ((is-line-overflow (> (current-column) core--default-fill-column))
           (prev-cur-color (face-background 'cursor))
           (prev-modeline-color (and (facep 'doom-modeline-bar)
                                     (face-background 'doom-modeline-bar)))
           (is-god-mode (and (boundp 'god-local-mode)
                             god-local-mode))
           (cur-color (cond (buffer-read-only "Gray")
                            (is-line-overflow "IndianRed")
                            (overwrite-mode "yellow")
                            (t "#268bd2")))
           (cur-type (cond (buffer-read-only 'box)
                           ((and overwrite-mode is-god-mode) 'hollow)
                           ((or is-god-mode overwrite-mode) 'box)
                           (t 'bar)))
           (next-mode-string (cond ((or is-god-mode
                                        (and overwrite-mode is-god-mode))
                                    holy-emacs-modeline-god-mode-indicator)
                                   (overwrite-mode
                                    holy-emacs-modeline-overwrite-mode-indicator)
                                   (t " "))))
      (unless (eq prev-cur-color cur-color)
        (set-cursor-color cur-color))
      (when (and (facep 'doom-modeline-bar)
                 (not (eq prev-modeline-color cur-color)))
        (set-face-attribute 'doom-modeline-bar nil :background cur-color)
        (doom-modeline-refresh-bars))

      (setq cursor-type cur-type)
      (setq core--modeline-mode-string next-mode-string)))

  (add-hook! 'post-command-hook #'core--configure-mode)

  :config
  (defun +god--toggle-on-overwrite ()
    (if (bound-and-true-p overwrite-mode)
        (god-local-mode-pause)
      (god-local-mode-resume)))

  (let ((exempt-modes '(Custom-mode
                        Info-mode
                        ag-mode
                        calendar-mode
                        calculator-mode
                        cider-test-report-mode
                        compilation-mode
                        debugger-mode
                        dired-mode
                        edebug-mode
                        ediff-mode
                        eww-mode
                        geben-breakpoint-list-mode
                        ibuffer-mode
                        org-agenda-mode
                        recentf-dialog-mode
                        sldb-mode
                        sly-db-mode
                        wdired-mode
                        )))
    (cl-loop for mode in exempt-modes
             do (add-to-list 'god-exempt-major-modes mode))))

(load! "+editor")
(load! "+files")
(load! "+lang")
(load! "+vc")
(load! "+ui")
(load! "+os")
(load! "+bindings")
