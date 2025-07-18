;;; knot-keybindings.el --- All keybindings with or without general.el -*- lexical-binding: t; -*-

;;;; General

(use-package general :straight t :demand t :after outline
  :config
  (general-create-definer rh/leader-keys
    :states '(normal visual)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (rh/leader-keys
    ;; the best and most used ones
    "SPC o"   'rh/toggle-org-scratch
    "SPC l"   'rh/toggle-lean-scratch

    ;; eshell
    "e t"     'rh/eshell-toggle

    ;; eval
    "e e"     'eval-expression

    ;; shell command
    "e s"     'shell-command

    ;; git (magit)
    "g s"     'magit-status

    ;; outline minor mode
    "o t"     'rh/outline-toggle-heading
    "o <tab>" 'rh/outline-toggle-heading
    "o a"     'rh/outline-toggle-visibility

    ;; string manipulation
    "s r"     'replace-string
    "s w"     'delete-trailing-whitespace
    "s a"     'abbrev-mode

    ;; vterm
    "t t"     'rh/vterm-toggle
    
    ;; utilities
    "u r"     'recentf-open-files
    ))

;; All custom keybindings

;; (global-set-key (kbd "<f5>") #'rh/cycle-modus-themes)

(provide 'knot-keybindings)
