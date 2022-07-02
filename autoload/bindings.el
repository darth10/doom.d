;;; ~/.doom.d/autoload/bindings.el -*- lexical-binding: t; -*-

;;;###autoload
(defvar +bindings-buffer-repeat-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<left>")  #'previous-buffer)
    (define-key map (kbd "<right>") #'next-buffer)
    map))

;;;###autoload
(defvar +bindings-flycheck-errors-repeat-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "p") #'flycheck-previous-error)
    (define-key map (kbd "n") #'flycheck-next-error)
    map))
