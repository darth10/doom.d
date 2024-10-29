;;; ~/.doom.d/autoload/bindings.el -*- lexical-binding: t; -*-

;;;###autoload
(defvar +bindings-buffer-repeat-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "[")  #'previous-buffer)
    (define-key map (kbd "]") #'next-buffer)
    (define-key map (kbd "<left>")  #'previous-buffer)
    (define-key map (kbd "<right>") #'next-buffer)
    map))

;;;###autoload
(defvar +bindings-editor-move-text-repeat-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<up>")   #'+editor/move-text-up)
    (define-key map (kbd "k")      #'+editor/move-text-up)
    (define-key map (kbd "<down>") #'+editor/move-text-down)
    (define-key map (kbd "j")      #'+editor/move-text-down)
    map))
