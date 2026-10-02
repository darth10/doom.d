;;; +llm.el -*- lexical-binding: t; -*-

(after! gptel
  (setq gptel-use-curl t
        gptel-stream t
        gptel-default-mode 'org-mode
        gptel-log-level 'info
        gptel-model 'claude-opus-5
        gptel-backend (gptel-make-anthropic "Claude"
                        :stream t
                        :key #'+gptel-anthropic-key)))

(use-package! ai-code
  :defer t
  :init
  (setq ai-code-onboarding-auto-show nil
        ai-code-auto-test-type 'ask-me
        ai-code-backends-infra-terminal-backend 'ghostel
        ai-code-backends-history-file (doom-profile-data-dir t "ai-code-backends-history.el")
        ai-code-git-worktree-root (doom-profile-data-dir t "ai-code-worktrees/"))
  (map! :leader
        (:prefix "c"
         :desc "Show AI code interface menu"
         "," #'ai-code-menu
         :desc "Send command to AI session"
         "." #'ai-code-send-command))
  :config
  (ai-code-set-backend 'claude-code))

(after! magit
  (autoload 'ai-code-pull-or-review-diff-file "ai-code" nil t)
  (autoload 'ai-code-magit-log-analyze "ai-code" nil t)
  (autoload 'ai-code-magit-blame-analyze "ai-code" nil t)
  (transient-append-suffix 'magit-diff "r"
    '("A" "AI Code: Review/generate diff" ai-code-pull-or-review-diff-file))
  (transient-append-suffix 'magit-blame "b"
    '("A" "AI Code: Analyze blame" ai-code-magit-blame-analyze))
  (transient-append-suffix 'magit-log "b"
    '("A" "AI Code: Analyze log" ai-code-magit-log-analyze)))
