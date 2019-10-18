;;; ~/.doom.d/init.el -*- lexical-binding: t; -*-

(doom! :completion
       company
       helm

       :ui
       doom
       doom-quit
       fill-column
       hl-todo
       modeline
       nav-flash
       neotree
       ophints
       (popup +all +defaults)
       vc-gutter
       window-select
       workspaces

       :editor
       god
       file-templates
       fold
       lispy
       multiple-cursors
       rotate-text
       snippets
       
       :emacs
       dired
       electric
       vc

       :term
       eshell
       shell

       :tools
       debugger
       docker
       editorconfig
       eval
       flycheck
       gist
       (lookup +docsets)
       lsp
       magit
       make
       pdf
       terraform

       :lang
       cc
       clojure
       common-lisp
       csharp
       data
       emacs-lisp
       go
       (haskell +intero)
       javascript
       (markdown +grip)
       nix
       (org +dragndrop +ipython +pandoc +present +pomodoro)
       php
       plantuml
       python
       racket
       rest
       ruby
       scala
       scheme
       sh
       web

       :app
       calendar

       :config
       (default +bindings +smartparens))

(setq custom-file (expand-file-name "custom.el" doom-local-dir))
(load custom-file 'no-error 'no-message)
