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

(use-package doom-themes)
(setq doom-themes-enable-bold t
      doom-themes-enable-italics t)
(load-theme 'doom-outrun-electric t)

(use-package doom-modeline :init (doom-modeline-mode 1))

(column-number-mode)
(setq display-line-numbers-type 'relative)
  (add-hook 'prog-mode-hook 'display-line-numbers-mode)
  (add-hook 'conf-mode-hook 'display-line-numbers-mode)

    (display-time-mode 1)

(defun mj/set-font-faces()
(message "Loading fonts!")
(set-face-attribute 'default nil :font "VictorMono Nerd Font Mono" :height 240 :weight 'medium)
(set-face-attribute 'fixed-pitch nil :font "VictorMono Nerd Font Mono" :height 240 :weight 'medium)
(set-face-attribute 'variable-pitch nil :font "IBM Plex Sans" :height 250 ))

(if (daemonp) (add-hook 'server-after-make-frame-hook (lambda (frame) (setq doom-modeline-icon t) (with-selected-frame frame (mj/setfont-faces)))) (mj/set-font-faces))

(use-package centaur-tabs)

(use-package swiper)
     (use-package ivy
        :diminish
        :bind (("C-s" . swiper)
               :map ivy-minibuffer-map
               ("TAB" . ivy-alt-done)
               ("C-l" . ivy-alt-done)
               ("C-k" . ivy-next-line)
               ("C-j" . ivy-previous-line)
               :map ivy-switch-buffer-map
               ("C-k" . ivy-previous-line)
               ("C-l" . ivy-done)
               ("C-d" . ivy-switch-buffer-kill)
               :map ivy-reverse-i-search-map
               ("C-k" . ivy-previous-line)
               ("C-d" . ivy-previous-i-search-kill))
      :config
      (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . counsel-minibuffer-history)))

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

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 1))

(use-package typescript-mode
  :mode "\\.ts\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

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
  (setq org-ellipsis " ▾")
  (mj/org-font-setup)
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


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("a82ab9f1308b4e10684815b08c9cac6b07d5ccb12491f44a942d845b406b0296" "c5ded9320a346146bbc2ead692f0c63be512747963257f18cc8518c5254b7bf5" "da53441eb1a2a6c50217ee685a850c259e9974a8fa60e899d393040b4b8cc922" "333958c446e920f5c350c4b4016908c130c3b46d590af91e1e7e2a0611f1e8c5" "3d54650e34fa27561eb81fc3ceed504970cc553cfd37f46e8a80ec32254a3ec3" "246a9596178bb806c5f41e5b571546bb6e0f4bd41a9da0df5dfbca7ec6e2250c" "a7b20039f50e839626f8d6aa96df62afebb56a5bbd1192f557cb2efb5fcfb662" "7eea50883f10e5c6ad6f81e153c640b3a288cd8dc1d26e4696f7d40f754cc703" "5784d048e5a985627520beb8a101561b502a191b52fa401139f4dd20acb07607" "97db542a8a1731ef44b60bc97406c1eb7ed4528b0d7296997cbb53969df852d6" "f91395598d4cb3e2ae6a2db8527ceb83fed79dbaf007f435de3e91e5bda485fb" "4f1d2476c290eaa5d9ab9d13b60f2c0f1c8fa7703596fa91b235db7f99a9441b" "0b3aee906629ac7c3bd994914bf252cf92f7a8b0baa6d94cb4dfacbd4068391d" "d268b67e0935b9ebc427cad88ded41e875abfcc27abd409726a92e55459e0d01" "d47f868fd34613bd1fc11721fe055f26fd163426a299d45ce69bef1f109e1e71" default))
 '(package-selected-packages
   '(typescript-mode company lsp-mode which-key vterm use-package smartparens rainbow-delimiters projectile org-superstar ivy-rich hydra helpful general forge flycheck evil-collection doom-themes doom-modeline counsel command-log-mode centaur-tabs)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
