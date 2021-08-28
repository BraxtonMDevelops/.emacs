(server-start)
(require 'package)


  (setq package-archives '(("melpa" . "https://melpa.org/packages/")
                           ("org" . "https://orgmode.org/elpa/")
                           ("elpa" . "https://elpa.gnu.org/packages/")))

  (package-initialize)
  (unless package-archive-contents
    (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(use-package all-the-icons)

(use-package treemacs-all-the-icons
  :after treemacs)
(use-package treemacs
 :defer t
 :init
 (setq treemacs-follow-after-init t
       treemacs-is-never-other-window t)
 :config
 (treemacs-follow-mode -1)
 (require 'treemacs-all-the-icons)
 (treemacs-load-theme "all-the-icons"))
(use-package treemacs-evil
  :defer t
  :init
  :after treemacs (require 'treemacs-evil))
(use-package treemacs-projectile
  :after treemacs)
(use-package treemacs-magit
  :after treemacs magit)
(use-package lsp-treemacs
  :after(treemacs lsp))

(use-package doom-themes
  :demand t)
(setq doom-themes-enable-bold t
      doom-themes-enable-italics t)
(load-theme 'doom-outrun-electric t)

(use-package doom-modeline :init (doom-modeline-mode 1))

(column-number-mode)
(setq display-line-numbers-type 'relative)
  (add-hook 'prog-mode-hook 'display-line-numbers-mode)
  (add-hook 'conf-mode-hook 'display-line-numbers-mode)

    (display-time-mode 1)

(set-face-attribute 'default nil :font "VictorMono Nerd Font Mono" :height 240 :weight 'medium)
(set-face-attribute 'fixed-pitch nil :font "VictorMono Nerd Font Mono" :height 240 :weight 'medium)
(set-face-attribute 'variable-pitch nil :font "IBM Plex Sans" :height 250 )
(defun mj/set-font-faces()
(message "Loading fonts!")
(set-face-attribute 'default nil :font "VictorMono Nerd Font Mono" :height 240 :weight 'medium)
(set-face-attribute 'fixed-pitch nil :font "VictorMono Nerd Font Mono" :height 240 :weight 'medium)
(set-face-attribute 'variable-pitch nil :font "IBM Plex Sans" :height 250 ))

(if (daemonp) (add-hook 'server-after-make-frame-hook (lambda (frame) (setq doom-modeline-icon t) (with-selected-frame frame (mj/setfont-faces)))) (mj/set-font-faces))

(use-package centaur-tabs)

(use-package ligature
  :load-path "/home/mjolnir/.emacs/ligature.el"
  :config 
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                       ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                       "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                       "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                       "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                       "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                       "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                       "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                       ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                       "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                       "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                       "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                       )) 
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-up-directory
    "l" 'dired-find-file))

(use-package vertico
  :bind (:map vertico-map
              ("C-j" . vertico-next)
              ("C-k" . vertico-previous)
              :map minibuffer-local-map
              ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package marginalia
  :bind (("M-A" . marginalia-cycle)
        :map minibuffer-local-map
        ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

(use-package all-the-icons-completion 
  :hook ('marginalia-mode-hook #'all-the-icons-completion-marginalia-setup))
(all-the-icons-completion-mode)

(use-package savehist
   :init
   (savehist-mode))

(use-package consult
  :bind (("C-s" . consult-line)))

(use-package orderless
   :init
   (setq completion-styles '(orderless)
         completion-category-defaults nil
         completion-category-overrides '((file (styles partial-completion)))))

;;(use-package swiper)
;;     (use-package ivy
;;        :diminish
  ;      :bind (("C-s" . swiper)
  ;             :map ivy-minibuffer-map
  ;             ("TAB" . ivy-alt-done)
  ;             ("C-l" . ivy-alt-done)
  ;             ("C-k" . ivy-next-line)
  ;           ("C-j" . ivy-previous-line)
  ;            :map ivy-switch-buffer-map
  ;             ("C-k" . ivy-previous-line)
 ;              ("C-l" . ivy-done)
;;               ("C-d" . ivy-switch-buffer-kill)
;;               :map ivy-reverse-i-search-map
;;               ("C-k" . ivy-previous-line)
;;               ("C-d" . ivy-previous-i-search-kill))
;;      :config
;;     (ivy-mode 1))

;;    (use-package ivy-rich
;      :init
;    (ivy-rich-mode 1))

;;         (use-package counsel
;;         :bind (("M-x" . counsel-M-x)
;;              ("C-x b" . counsel-ibuffer)
;;            ("C-x C-f" . counsel-find-file)
;;          :map minibuffer-local-map
;;        ("C-r" . counsel-minibuffer-history)))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-function-variable #'helpful-variable)
  :bind
  ([remap-desrcibe-function] . counsel-describe-function)
  ([remap-describe-command] . helpful-command)
  ([remap-describe-variable] . counsel-describe-variable)
  ([remap-describe-key] . helpful-key))

(use-package flycheck
  :init
  (global-flycheck-mode t))

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package vterm)

(use-package rainbow-delimiters
  :hook(prog-mode . rainbow-delimiters-mode))

(use-package smartparens)
(smartparens-global-mode t)
(show-paren-mode 1)



(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)

  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'message-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package which-key
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.25))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package general)

(defun mj/lsp-mode-setup ()
    (setq company-minimum-prefix-length 1))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . mj/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-position 'bottom))

(setq gc-cons-threshold 100000000)

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(use-package lsp-julia
  :after lsp-mode)

(use-package julia-mode
    :hook (julia-mode . lsp-deferred)
    :interpreter "julia")

(use-package julia-repl
  :hook (julia-mode . julia-repl-mode))

(use-package python-mode
  :hook (python-mode . lsp-deferred)
  :custom
  (python-shell-interpreter "python3"))

(use-package haskell-mode)

(use-package rustic
  :mode ("\\.rs$" . rustic-mode)
  :hook (rustic-mode . lsp-deferred)
  :init
  (add-to-list 'org-src-lang-modes ("rust" . rustic))
  :config
  (setq rustic-indent-method-chian t)
  (setq rustic-lsp-client 'rust-analyzer)

(defun mj/org-font-setup ()

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "IBM Plex Sans" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

(defun mj/org-mode-setup()
  (mj/org-font-setup)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq-default truncate-lines t)
  (setq evil-auto-indent nil)
  (org-indent-mode))

(use-package org-superstar  
:after org
:hook (org-mode . org-superstar-mode)
:custom
(org-superstar-remove-leading-stars t)
(org-superstar-headline-bullets-list '("☕" "☀" "☎" "☞" "☭" "☯" "☮")))

(use-package org
  :hook (org-mode . mj/org-mode-setup)
  :config
  (setq org-src-fontify-natively t)
  (setq org-ellipsis " ▾")
  (setq org-agenda-start-with-time-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-agenda-files
        '("~/Org/Tasks.org")))

(require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
(setq org-confirm-babel-evaluate nil)

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
   (python . t))))

(defun mj/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/.emacs/Emacs.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'mj/org-babel-tangle-config)))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Development")
    (setq projectile-project-search-path '("~/Development")))
   (setq projectile-switch-project-action #'projectile-dired))

(setq auth-sources '("~/.authinfo"))

(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package forge
  :after magit)
