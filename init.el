;;; ~/.doom.d/init.el -*- lexical-binding: t; -*-

(doom! :completion
       (company +childframe)
       vertico

       :ui
       doom
       doom-quit
       hl-todo
       indent-guides
       (ligatures +extra)
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
       ;; god
       (evil +everywhere)
       file-templates
       fold
       format
       lispy
       multiple-cursors
       rotate-text
       snippets
       (whitespace +trim)

       :emacs
       (dired +dirvish +icons)
       electric
       undo
       vc

       :term
       eshell
       shell

       :tools
       debugger
       direnv
       docker
       editorconfig
       eval
       (lookup +docsets)
       lsp
       (magit +forge)
       make
       pass
       pdf
       terraform

       :lang
       ;; cc
       (clojure +lsp)
       ;; common-lisp
       ;; (csharp +lsp)
       data
       emacs-lisp
       ;; go
       ;; (haskell +dante +lsp)
       (javascript +lsp)
       ;; lua
       (latex +lsp)
       (markdown +grip)
       (nix +lsp)
       (org +brain +dragndrop +gnuplot +ipython +pandoc +pomodoro +present)
       ;; php
       plantuml
       ;; python
       rest
       ;; ruby
       ;; scala
       ;; (scheme +racket)
       (sh +lsp)
       (web +css +lsp)
       (yaml +lsp)

       :app
       calendar

       :config
       (default +bindings +smartparens))
