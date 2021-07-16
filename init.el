;Quality of Life Changes

(menu-bar-mode -1)
(scroll-bar-mode -1) ;Disables the shown scrollbar
(tooltip-mode -1) ;Disables tooltips
(tool-bar-mode -1) ;Disables the toolbar
(set-fringe-mode 10) ;More fringe :D



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
  (ivy-mode 1))
