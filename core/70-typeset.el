;;; 70-typeset.el --- description -*- lexical-binding: t; -*-

;; Typesetting (Markdown, TeX, LaTeX, etc)

(use-package flymd)                                         ; markdown live preview

(use-package auctex
  :ensure t)

(use-package auctex-latexmk
  :config
  (auctex-latexmk-setup))

(use-package cdlatex
  :ensure t
  :hook ((LaTeX-mode . turn-on-cdlatex)
         (org-mode . turn-on-org-cdlatex))
  :config
  (setq cdlatex-env-alist
	'(("axiom" "\\begin{axiom}\nAUTOLABEL\n?\n\\end{axiom}\n" nil)                 ; AUTOLABEL
	  ("defintion" "\\begin{definition}\nAUTOLABEL\n?\n\\end{definition}\n" nil)
	  ("lemma" "\\begin{lemma}\nAUTOLABEL\n?\n\\end{lemma}\n" nil)
	  ("proposition" "\\begin{proposition}\nAUTOLABEL\n?\n\\end{proposition}\n" nil)
	  ("theorem" "\\begin{theorem}\nAUTOLABEL\n?\n\\end{theorem}\n" nil)
	  ("corollary" "\\begin{corollary}\nAUTOLABEL\n?\n\\end{corollary}\n" nil)))
  (setq cdlatex-command-alist
	'(("ax" "Insert axiom env" "" cdlatex-environment ("axiom") t nil)             ; ax TAB -> axiom env
	  ("df" "Insert definition env" "" cdlatex-environment ("definition") t nil)   ; df TAB -> definition env
	  ("lm" "Insert lemma env" "" cdlatex-environment ("lemma") t nil)             ; lm TAB -> lemma env	
	  ("pp" "Insert proposition env" "" cdlatex-environment ("proposition") t nil) ; pp TAB -> propositin env
	  ("th" "Insert theorem env" "" cdlatex-environment ("theorem") t nil)         ; th TAB -> theorem env
	  ("cl" "Insert corollary env" "" cdlatex-environment ("corollary") t nil)     ; cl TAB -> corollary env
	  ("pr" "Insert proof env" "" cdlatex-environment ("proof") t nil))))          ; pr TAB -> proof env


;;(use-package auto-complete-auctex)

(provide '70-typeset)
