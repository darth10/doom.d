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
        ai-code-backends-infra-terminal-backend 'ghostel)
  (map! :leader
        (:prefix "c"
         :desc "Show AI code interface menu"
         "," #'ai-code-menu))
  :config
  (ai-code-set-backend 'claude-code)
  (after! evil
    (ai-code-backends-infra-evil-setup))
  (after! magit
    (ai-code-magit-setup-transients)))
