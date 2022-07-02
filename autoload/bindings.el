;;; ~/.doom.d/autoload/bindings.el -*- lexical-binding: t; -*-

;;;###autoload
(defvar +bindings-buffer-repeat-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<left>")  #'previous-buffer)
    (define-key map (kbd "<right>") #'next-buffer)
    map))

;;;###autoload
(defvar +bindings-editor-move-text-repeat-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<up>")   #'+editor/move-text-up)
    (define-key map (kbd "p")      #'+editor/move-text-up)
    (define-key map (kbd "<down>") #'+editor/move-text-down)
    (define-key map (kbd "n")      #'+editor/move-text-down)
    map))

;;;###autoload
(defvar +bindings-flycheck-errors-repeat-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "p") #'flycheck-previous-error)
    (define-key map (kbd "n") #'flycheck-next-error)
    map))
