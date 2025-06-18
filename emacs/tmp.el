;; To set the size and positon of Emacs window at startup
(setq default-frame-alist
      '((width . 105)           ;; Sets the number of characters
        (height . 90)
        (top . 50)
        (left . 230)))

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

;;(use-package adwaita-dark-theme
;;  :ensure t
;;  :config
;;  (load-theme 'adwaita-dark))

;;(use-package ample-theme
;;  :ensure t
;;  :config
;;  (load-theme 'ample))

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

;; other packages
;; lean4-mode
;;(use-package lean4-mode
;;  :load-path "~/.emacs.d/lean4-mode"
;;  :hook (lean4-mode . eglot-ensurpe))
