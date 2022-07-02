;;; ~/.doom.d/autoload/bindings.el -*- lexical-binding: t; -*-

;;;###autoload
(defvar +bindings-buffer-repeat-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<left>")  #'previous-buffer)
    (define-key map (kbd "<right>") #'next-buffer)
    map))
