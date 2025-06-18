(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")            ;; MELPA
        ("gnu" . "https://elpa.gnu.org/packages/")           ;; GNU ELPA
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))     ;; nonGNU ELPA
(package-initialize)

(unless (package-installed-p 'use-package)                   ;; Install use-package if not installed already
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;; ===== LOOKS, THEMES, ETC. =====

(menu-bar-mode -1)                                           ;; hide menu bar
(tool-bar-mode -1)                                           ;; hide tool bar
(scroll-bar-mode -1)                                         ;; hide scroll bar
(set-fringe-mode 0)                                          ;; try other values too
(global-visual-line-mode t)                                  ;; automatic line wrapping
(setq-default cursor-type 'bar)                              ;; cursor: thin vertical line
(blink-cursor-mode 1)
(global-prettify-symbols-mode 1) 
(global-display-line-numbers-mode t)                         ;; show line numbers
(setq make-backup-files nil)                                 ;; don't generate backup files

(use-package catppuccin-theme                                ;; dark theme
  :ensure t
  :config
  (load-theme 'catppuccin t))

;;(use-package gotham-theme                                    ;; a really dark theme
;;  :ensure t
;;  :config
;;  (load-theme 'gotham t))

;;(use-package gandalf-theme                                   ;; light theme
;;  :ensure t
;;  :config
;;  (load-theme 'gandalf t))

(use-package doom-modeline                                   ;; modeline customization
  :ensure t
  :init
  (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 25)
  (doom-modeline-bar-width 6)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon t)
  (doom-modeline-buffer-file-name-style 'truncate-upto-project)
  (doom-modeline-project-detection 'project)
  (doom-modeline-env-version t)
  (doom-modeline-lsp t)
  (doom-modeline-github nil))

(use-package nyan-mode                                       ;; nyan cat in the modeline representing buffer position
  :ensure t
  :config
  (nyan-mode 1))                                             ;; enabling it globally

(use-package nerd-icons
  :ensure t)

(use-package rainbow-delimiters                              ;; different color for each pair of parenthesis
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))


;;(use-package all-the-icons-dired                           ;; use icons for dired mode
;;  :ensure t
;;  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dashboard                                       ;; customize the dashboard
  :ensure t
  :config
  (setq dashboard-startup-banner '2
        dashboard-banner-logo-title "Ronald Huidrom"
        dashboard-center-content t
        dashboard-show-time t
        dashboard-set-heading-icons t
        dashboard-heading-font-size 1
        dashboard-set-file-icons t
        dashboard-footer-messages '("One editor to rule them all"))
  (dashboard-setup-startup-hook)
  (custom-set-faces '(dashboard-startup-banner ((t(:foreground "green"))))))

(defun rhuid/open-dashboard-if-scratch ()                    ;; to open dashboard, instead of scratch, when starting new client 
  "Show dashboard if the current buffer is *scratch*."
  (when (and (equal (buffer-name) "*scratch*")
             (not (buffer-file-name)))
    (dashboard-open)))
(add-hook 'emacs-startup-hook #'rhuid/open-dashboard-if-scratch) ;; show dashboard after emacs starts (initial frame)
(add-hook 'server-after-make-frame-hook #'rhuid/open-dashboard-if-scratch) ;; show it when a new frame is created via emacsclient

;; ===== ORG MODE =====
(require 'org)

(use-package ox-reveal                                        ;; nice looking HTML presentations
  :ensure t
  :after org
  :config
  (setq org-re-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
  (add-to-list 'org-export-backends 'reveal))

(setq org-startup-indented t
      org-hide-emphasis-markers t
      org-ellipsis " ▾ "                                      ;; folding symbol
      org-pretty-entities t                                   ;; pretty TeX symbols
      org-log-done 'time                                      ;; log time when a task is marked done
      org-hide-leading-stars t
      org-startup-folded 'content)                            ;; show content folded by default

(use-package org-modern                                       ;; visual improvements for org mode
  :ensure t
  :hook (org-mode . org-modern-mode))

;; ===== CODING =====

(add-to-list 'load-path "~/.emacs.d/lean4-mode")              ;; lean4-mode is installed manually in this path
(require 'lean4-mode)

(add-to-list 'auto-mode-alist '("\\.lean\\'" . lean4-mode))
(add-hook 'lean4-mode-hook #'eglot-ensure)                    ;; enable LSP when Lean files are opened
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(lean4-mode . ("lake" "serve"))))             ;; invoke lake server in lean4-mode
(add-hook 'lean4-mode-hook #'flymake-mode)                 

(use-package flycheck-rust
  :hook (rust-mode . flycheck-rust-setup))

(setq lsp-log-io nil)                                         ;; Suppress LSP warnings

;; ===== MARKDOWN, LATEX, ETC =====

(use-package flymd)                                           ;; Markdown live preview

(use-package auctex
  :ensure t)

(use-package auctex-latexmk
  :config
  (auctex-latexmk-setup))

;;(use-package auto-complete-auctex)

;; ===== Dired =====

;;(use-package ranger                   ;; Make dired ranger-like
;;  :config
;;  (ranger-override-dired-mode t))

;; ===== Others =====

;;(use-package auto-complete
;;  :config
;;  (ac-config-default))

;; =======================
;; Customs (M-x customize)
;; =======================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("5a548c9d5a6ca78d13283ed709bddf3307b65a7695e1b2e2b7e0a9dde45e8599"
     "0a076beea7570c3047225baf40783d7ce1576b8b98cdcd3e5622808875ab8c00"
     "a68ec832444ed19b83703c829e60222c9cfad7186b7aea5fd794b79be54146e6"
     "6e18353d35efc18952c57d3c7ef966cad563dc65a2bba0660b951d990e23fc07"
     default))
 '(package-selected-packages
   '(adwaita-dark-theme afternoon-theme all-the-icons-dired
			amber-glow-theme ample-theme ample-zen-theme
			auctex-latexmk auto-complete-auctex
			catppuccin-theme company dashboard
			doom-modeline doom-themes ef-themes
			exec-path-from-shell flycheck-rust flymd
			gandalf-theme gotham-theme haskell-mode
			julia-mode lsp-ui magit-section nim-mode
			nyan-mode org-modern ox-reveal
			rainbow-delimiters rainbow-mode ranger
			rust-mode))
 '(package-vc-selected-packages
   '((lean4-mode :url
		 "https://github.com/leanprover-community/lean4-mode.git"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dashboard-startup-banner ((t (:foreground "green")))))
