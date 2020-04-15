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

       :checkers
       syntax

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
       (haskell +dante)
       javascript
       lua
       (markdown +grip)
       nix
       (org +dragndrop +gnuplot +ipython +pandoc +pomodoro +present)
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
