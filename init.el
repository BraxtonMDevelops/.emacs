;;Allows me to write this config literatlly
;;(org-babel-load-file (expand-file-name "config.org"  user-emacs-directory))


;;Quality of Life Changes

(menu-bar-mode -1)
(scroll-bar-mode -1) ;Disables the shown scrollbar
(tooltip-mode -1) ;Disables tooltips
(tool-bar-mode -1) ;Disables the toolbar
(set-fringe-mode 10) ;More fringe :D
(defconst custom-file "/dev/null")


;;Enable visual bell

(setq visible-bell t)

;;Set font
(set-face-attribute 'default nil :font "VictorMono Nerd Font Mono" :height 240 :weight 'medium)
;;(set-face-attribute 'default nil :font "Monofur Nerd Font Mono" :height 240)
;; FantasqueSans Mono Nerd Font
(set-face-attribute 'fixed-pitch nil :font "VictorMono Nerd Font Mono" :height 240 :weight 'medium)
(set-face-attribute 'variable-pitch nil :font "IBM Plex Sans" :height 250)

;;Setting up package archives and stuff
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package command-log-mode)
(use-package swiper)
(use-package counsel) 
;;Makes quitting a little bit ezpzer
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-previous-i-search-kill))
  :config
  (ivy-mode 1))

;;set up smartparens
(use-package smartparens)
(smartparens-global-mode t)
(show-paren-mode 1)
;; Sets up Doom Modeline & Doom Theme
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))
  
(use-package doom-themes)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled
(load-theme 'doom-outrun-electric t)

;;Setting up which-key
(use-package which-key
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.25))

;; making line numbers nad the modeline mine.
(column-number-mode)
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'conf-mode-hook 'display-line-numbers-mode)

	  
(display-time-mode 1)

;;Rainbow delimiters in programming things

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;;make counsel the default for lots of things
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . counsel-minibuffer-history)))

;; Make things more helpful
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))
  
;; Gives more context to ivy
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;;Installing libvterm for a better terminal
(use-package vterm)

;;sets up a leader key
(use-package general
  
  :config
  (general-evil-setup)
   (general-def
     :states '(normal motion)
     "SPC" nil)

   (general-create-definer mj-noleader-def
     :states '(normal motion)
     :keymaps 'override)
   (general-create-definer mj/leader-key-def
     :prefix "SPC"
     :states '(normal motion)
     :keymaps 'override))


;;Doing Evil
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

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))
(use-package evil-collection
  :after evil
  :config
  (setq evil-collection-mode-list
        (remove 'lispy evil-collection-mode-list))
  (evil-collection-init))
;;Hydra Ezpz repetetive keybinds setup

(use-package hydra)

;; More Basic Configurations for Org

(defun mj/org-mode-setup ()
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil)
  (org-indent-mode))
  
;; Setting up nonsense bullets
 
  (use-package org-superstar  
  :after org
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-remove-leading-stars t)
  (org-superstar-headline-bullets-list '("☕" "☀" "☎" "☞" "☭" "☯" "☮")))

(defun mj/org-font-setup ()
  ;; Replace list hyphen with dot

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


;;Setting other faces to be fixed-pitch so that it looks right

(use-package org
  :hook (org-mode . mj/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")
  (mj/org-font-setup)
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-agenda-files
	'("~/Org/Tasks.org")))


;; Making org-mode smarter
(with-eval-after-load 'org
  (org-babel-do-load-languages
      'org-babel-load-languages
      '((emacs-lisp . t)
      (python . t)))

  (push '("conf-unix" . conf-unix) org-src-lang-modes))

;; Setting up projectile
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Development")
    (setq projectile-project-search-path '("~/Development")))
  (setq projectile-switch-project-action #'projectile-dired))

;; Setting up basics of Magit

(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))


