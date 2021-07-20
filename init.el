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
(set-face-attribute 'default nil :font "Monofur Nerd Font Mono" :height 240)

(load-theme 'tango-dark)


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


;; Sets up Doom Modeline & Doom Theme
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))
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
  (evil-collection-init))

;;Hydra Ezpz repetetive keybinds setup

(use-package hydra)

;; Making org-mode smarter
(with-eval-after-load 'org
  (org-babel-do-load-languages
      'org-babel-load-languages
      '((emacs-lisp . t)
      (python . t)))

  (push '("conf-unix" . conf-unix) org-src-lang-modes))

