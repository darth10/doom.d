;;; ~/.doom.d/autoload/lang.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +clojure-thread-oneline ()
  (when (functionp #'lispy-oneline)
    (lispy-oneline)))

;;;###autoload
(defun +clojurescript-run-cljsbuild ()
  (interactive)
  (let ((default-directory (expand-file-name (vc-root-dir))))
    (make-comint "cljsbuild" "lein" nil "cljsbuild" "auto")
    (message "Started 'lein cljsbuild auto' in %s" default-directory)))
