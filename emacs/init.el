(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")            ;; MELPA
        ("gnu" . "https://elpa.gnu.org/packages/")           ;; GNU ELPA
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))     ;; nonGNU ELPA
(package-initialize)

;; Install use-package if not installed already
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;; LOOKS, THEMES, FONTS, ETC. ===============================================
;; Set size and place of Emacs session on desktop
(setq default-frame-alist
      '((width . 105)           ;; Sets the number of characters
        (height . 90)
        (top . 50)
        (left . 230)))

;; Hide menubar, toolbar, scrollbar, fringe, etc.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 0)  ;; try other values too
(visual-line-mode t) ;; automatic line wrapping

;; Cursor
(setq-default cursor-type 'bar) ;; thin vertical line
(blink-cursor-mode 1)

;; prettify
(global-prettify-symbols-mode 1)

(global-display-line-numbers-mode t) ;; Show line numbers

;; Don't generate backup files
(setq make-backup-files nil)

;; Themes

;;(defun rhuid/set-theme-based-on-time ()
;;  "Automatically set Emacs theme based on time of day.
;;Catppuccin during the day, Gotham after 6 PM."
;;  (let* ((hour (string-to-number (format-time-string "%H")))
;;         (night? (or (>= hour 18) (< hour 6))))
;;    (mapc #'disable-theme custom-enabled-themes)
;;    (if night?
;;        (load-theme 'gotham t)
;;      (load-theme 'catppuccin t))))
;; Run on Emacs startup
;;(add-hook 'emacs-startup-hook #'rhuid/set-theme-based-on-time)
;; Run every time a new client frame is created
;;(add-hook 'server-after-make-frame-hook #'rhuid/set-theme-based-on-time)

;;(use-package catppuccin-theme
;;  :ensure t
;;  :config
;;  (load-theme 'catppuccin t))

;;(use-package gandalf-theme
;;  :ensure t
;;  :config
;;  (load-theme 'gandalf t))

(use-package gotham-theme
  :ensure t
  :config
  (load-theme 'gotham t))

;;(use-package ef-themes
;;  :ensure t)
;;(load-theme 'ef-spring t)

;;(use-package doom-themes
;;  :ensure t
;;  :init                         ;; Runs before the package is loaded
;;  (setq doom-themes-enable-bold t
;;        doom-themes-enable-italic t)
;;  :config                       ;; Runs after the package is loaded
;;  (load-theme 'doom-one t)
;;  (doom-themes-org-config))     ;; Improved org-mode styling

;; Modeline customization
(use-package doom-modeline
  :ensure t
  :init
  (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 25)
  (doom-modeline-bar-width 3)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon t)
  (doom-modeline-buffer-file-name-style 'truncate-upto-project)
  (doom-modeline-project-detection 'project)
  (doom-modeline-env-version t)
;;  (doom-modeline-lsp t)
  (doom-modeline-github nil))

;; A nyan cat in the modeline representing buffer position
(use-package nyan-mode
  :ensure t
  :config
  (nyan-mode 1))                       ;; Enabling it globally

(use-package nerd-icons
  :ensure t)

(use-package rainbow-delimiters        ;; Different color for each pair of parenthesis
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; Make dired pretty
;;(use-package all-the-icons-dired
;;  :ensure t
;;  :hook (dired-mode . all-the-icons-dired-mode))

;; Dashboard
(use-package dashboard
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

(defun rhuid/open-dashboard-if-scratch ()
  "Show dashboard if the current buffer is *scratch*."
  (when (and (equal (buffer-name) "*scratch*")
             (not (buffer-file-name)))
    (dashboard-open)))
;; Show dashboard after emacs starts (initial frame)
(add-hook 'emacs-startup-hook #'rhuid/open-dashboard-if-scratch)
;; Also show it when a new frame is created via emacsclient
(add-hook 'server-after-make-frame-hook #'rhuid/open-dashboard-if-scratch)

;; ===== Org mode =====
(require 'org)

(use-package ox-reveal ;; nice looking HTML presentations
  :ensure t
  :after org
  :config
  (setq org-re-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
  (add-to-list 'org-export-backends 'reveal))

(setq org-startup-indented t
      org-hide-emphasis-markers t
      org-ellipsis " ▾ "               ;; folding symbol
      org-pretty-entities t            ;; pretty TeX symbols
      org-log-done 'time               ;; log time when a task is marked done
      org-hide-leading-stars t
      org-startup-folded 'content)     ;; show content folded by default

(use-package org-modern                ;; visual improvements
  :ensure t
  :hook (org-mode . org-modern-mode))

;; ===== Coding =====

;; other packages
;; lean4-mode
;;(use-package lean4-mode
;;  :load-path "~/.emacs.d/lean4-mode"
;;  :hook (lean4-mode . eglot-ensurpe))

(add-to-list 'load-path "~/.emacs.d/lean4-mode")
(require 'lean4-mode)

(add-to-list 'auto-mode-alist '("\\.lean\\'" . lean4-mode))
(add-hook 'lean4-mode-hook #'eglot-ensure)                     ;; enable LSP when Lean files are opened
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(lean4-mode . ("lake" "serve"))))
(add-hook 'lean4-mode-hook #'flymake-mode)                 



;;(use-package flycheck-rust
;;  :hook (rust-mode . flycheck-rust-setup))

(setq lsp-log-io nil)                  ;; Suppress LSP warnings

;; ===== Markdown and TeX =====

(use-package flymd) ;; Markdown live preview

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
 '(package-selected-packages nil)
 '(package-vc-selected-packages
   '((lean4-mode :url
		 "https://github.com/leanprover-community/lean4-mode.git"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dashboard-startup-banner ((t (:foreground "green")))))
