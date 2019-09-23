;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;;; KEYS

(unbind-key "C-h C-l")
(bind-key "C-h C-l" #'describe-personal-keybindings)

(unbind-key "C-z")
(bind-key "C-s" #'save-buffer)

(bind-key "M-s s" #'isearch-forward)
(bind-key "M-s M-s" #'isearch-forward)
(bind-key "M-s r" #'isearch-backward)
(bind-key "M-s M-r" #'isearch-backward)
(bind-key "<f3>"  #'isearch-repeat-forward isearch-mode-map)
(bind-key "S-<f3>" #'isearch-repeat-backward isearch-mode-map)

(defun core/match-paren (arg)
  "Go to the matching paren if the cursor is on a paren."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (message "%s" "No parenthesis under cursor!"))))

(bind-key "C-%" #'core/match-paren)

;;;  MODULES

(remove-hook! 'text-mode-hook #'vi-tilde-fringe-mode)
(remove-hook! 'prog-mode-hook #'vi-tilde-fringe-mode)

(after! dired
  (remove-hook! 'dired-mode-hook #'dired-omit-mode))

(after! flycheck
  (setq flycheck-emacs-lisp-load-path 'inherit))

(after! which-key
  :init
  (which-key-setup-side-window-bottom)
  (which-key-enable-god-mode-support)
  (setq which-key-max-description-length 24
        which-key-max-display-columns 4
        which-key-separator " : ")
  (unbind-key "C-h C-h")
  (which-key-mode t))

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

(after! doom-modeline
  (custom-set-faces
   '(doom-modeline-panel ((t (:inherit mode-line-emphasis))))
   '(doom-modeline-buffer-modified ((t (:inherit (warning bold) :background nil))))
   '(doom-modeline-inactive-bar ((t (:inherit mode-line-emphasis)))))

  (setq doom-modeline-height 40)

  (doom-modeline-def-segment cur-mode
    (if (doom-modeline--active)
        '(" " core--modeline-mode-string " ")
      "   "))

  (doom-modeline-def-modeline 'main
    '(workspace-name window-number bar cur-mode matches buffer-info-simple buffer-position selection-info)
    '(debug buffer-encoding major-mode process vcs checker))

  (doom-modeline-def-modeline 'helm
    '(bar helm-number helm-follow helm-prefix-argument)
    '(helm-help)))

(after! org
  (remove-hook! 'org-mode-hook #'org-bullets-mode)
  (setq org-startup-indented nil)
  (bind-key "C-c n" #'org-agenda org-mode-map))

(after! ox-reveal
  (setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/"))

(after! company
  (unbind-key "C-;")
  (bind-key "M-SPC" #'company-manual-begin))

(after! magit
  (bind-key "C-: :" #'magit-status)
  (bind-key "C-: C-:" #'magit-status))

(after! lispy
  (unbind-key "C-:" lispy-mode-map)
  (unbind-key "M-s" lispy-mode-map))

(after! multiple-cursors-core
  (bind-key "C-<" #'mc/mark-previous-like-this)
  (bind-key "C->" #'mc/mark-next-like-this))

(use-package! helm-swoop
  :after helm
  :bind (("M-]" . helm-swoop)
         ("M-s ]" . helm-swoop)))

(use-package! helm-ls-git
  :after helm
  :bind (("C-: f" . helm-ls-git-ls)
         ("C-: C-f" . helm-ls-git-ls)))

(use-package! god-mode
  :hook ((after-init . god-mode-all)
         (overwrite-mode . +god--toggle-on-overwrite))
  :bind (("<escape>" . god-local-mode)
         ("S-<escape>" . god-mode-all)
         ("M-i" . god-local-mode)
         :map god-local-mode-map
         ("." . repeat)
         ("z" . repeat)
         ("i" . god-local-mode))
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

  (let ((exempt-modes (list
                       'Custom-mode
                       'Info-mode
                       'ag-mode
                       'calendar-mode
                       'calculator-mode
                       'cider-test-report-mode
                       'compilation-mode
                       'debugger-mode
                       'dired-mode
                       'edebug-mode
                       'ediff-mode
                       'eww-mode
                       'geben-breakpoint-list-mode
                       'ibuffer-mode
                       'org-agenda-mode
                       'recentf-dialog-mode
                       'sldb-mode
                       'wdired-mode
                       )))
    (cl-loop for mode in exempt-modes
             do (add-to-list 'god-exempt-major-modes mode))))

(use-package! unicode-fonts
  :defer 2
  :config
  (unicode-fonts-setup))

;;;; UI

(defconst core--scratch-message-logo-text
  "
    ____  ____  ____  __  ___   ________  ______   ___________
   / __ \\/ __ \\/ __ \\/  |/  /  / ____/  |/  /   | / ____/ ___/
  / / / / / / / / / / /|_/ /  / __/ / /|_/ / /| |/ /    \\__ \\
 / /_/ / /_/ / /_/ / /  / /  / /___/ /  / / ___ / /___ ___/ /
/_____/\\____/\\____/_/  /_/  /_____/_/  /_/_/  |_\\____//____/

")

(defconst core--scratch-message-help-text
  "To open a file, type C-x C-f.
To display all available key bindings, type C-h C-l.
To quit a partially entered command, type C-g.
To quit Emacs, type C-x C-c.

For information about GNU Emacs and the GNU system, type C-h C-a.")

(defun core--get-scratch-message ()
  "Get message to show in *scratch* buffer."
  (let* ((face-for-logo 'font-lock-function-name-face)
         (face-for-keys 'font-lock-string-face)
         (face-for-comments 'font-lock-comment-delimiter-face)
         (version-text (concat
                        (propertize (format "doom %s"
                                            doom-version)
                                    'face face-for-logo)
                        " / "
                        (propertize (format "GNU Emacs %s"
                                            emacs-version)
                                    'face face-for-logo)))
         (help-text (replace-regexp-in-string
                     "C-." (lambda (s) (propertize s 'face face-for-keys))
                     (concat core--scratch-message-help-text "\n"
                             version-text))))
    (concat
     (replace-regexp-in-string
      "^" (propertize ";; " 'face face-for-comments)
      (propertize core--scratch-message-logo-text 'face face-for-logo))
     (replace-regexp-in-string
      "^" (propertize ";; " 'face face-for-comments)
      help-text)
     "\n\n")))

(setq initial-scratch-message (core--get-scratch-message))
(setq-default left-fringe-width 8
              right-fringe-width 8)

(blink-cursor-mode t)

(when IS-WINDOWS
  (add-hook 'window-setup-hook
            #'(lambda ()
                (w32-send-sys-command 61488))))
