;;; ~/.doom.d/autoload/lang.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +clojure-thread-oneline ()
  (when (functionp #'lispy-oneline)
    (lispy-oneline)))
