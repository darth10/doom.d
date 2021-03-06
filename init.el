;;; ~/.doom.d/init.el -*- lexical-binding: t; -*-

(doom! :completion
       company
       helm

       :ui
       doom
       doom-quit
       fill-column
       hl-todo
       indent-guides
       modeline
       nav-flash
       neotree
       ophints
       (popup +all +defaults)
       unicode
       vc-gutter
       window-select
       workspaces

       :checkers
       grammar
       syntax
       (spell +flyspell +aspell)

       :editor
       god
       file-templates
       fold
       format
       lispy
       multiple-cursors
       rotate-text
       snippets

       :emacs
       (dired +icons)
       electric
       undo
       vc

       :term
       eshell
       shell

       :tools
       debugger
       docker
       editorconfig
       eval
       gist
       (lookup +docsets)
       lsp
       magit
       make
       pass
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
       (org +brain +dragndrop +gnuplot +ipython +pandoc +pomodoro +present)
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
