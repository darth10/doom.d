;;; ~/.doom.d/init.el -*- lexical-binding: t; -*-

(doom! :completion
       company
       helm

       :ui
       doom
       doom-quit
       hl-todo
       indent-guides
       modeline
       nav-flash
       neotree
       ophints
       (popup +all +defaults)
       unicode
       (vc-gutter +pretty)
       window-select
       workspaces

       :checkers
       grammar
       (syntax +childframe)
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
       (magit +forge)
       make
       pass
       pdf
       terraform

       :lang
       cc
       (clojure +lsp)
       common-lisp
       (csharp +lsp)
       data
       emacs-lisp
       go
       (haskell +dante +lsp)
       (javascript +lsp)
       lua
       (markdown +grip)
       nix
       (org +brain +dragndrop +gnuplot +ipython +pandoc +pomodoro +present)
       php
       plantuml
       python
       rest
       ruby
       scala
       (scheme +racket)
       sh
       (web +lsp)
       (yaml +lsp)

       :app
       calendar

       :config
       (default +bindings +smartparens))
