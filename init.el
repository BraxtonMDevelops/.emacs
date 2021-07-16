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


;;Setting up packages
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages")))
(package-initialize)
(unless pakcage-archive-contents (package-refresh-contents))
