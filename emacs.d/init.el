(add-to-list 'load-path
             (expand-file-name "settings" user-emacs-directory))

;; load use-package
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)

;; Activate installed packages
(package-initialize)

;; allow custom themes
(setq custom-safe-themes t)

;; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; specify font for all unicode characters
(when (member "SauceCodePro Nerd Font" (font-family-list))
  (set-fontset-font t 'unicode "SauceCodePro Nerd Font-24" nil 'prepend))

;;;;;;;;;;;; General options ;;;;;;;;;;;;;;;;;;;

;; Disable all alarms / bells
(setq ring-bell-function 'ignore)

;; Dont use tabs for indenting
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; Confirm exit of emacs
(set-variable 'confirm-kill-emacs 'yes-or-no-p)

;; Disable splash and startup screens.
(setq inhibit-splash-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)

;; Disable menu bar, toolbar and scroll bars
(menu-bar-mode -1)
(tool-bar-mode -1)
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(show-paren-mode 1)

;; show parenthesis
(show-paren-mode 1)

;; show column numbers
(column-number-mode 1)

;; settings for fringe
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq-default left-fringe-width nil)
(setq-default indent-tabs-mode nil)

;; pretify symbols
(global-prettify-symbols-mode t)

;; highlight current line
(when window-system
  (global-hl-line-mode))

;; don't show warning for large files
(setq large-file-warning-threshold nil)
(setq split-width-threshold nil)

;; Follow symlinks without asking
(setq vc-follow-symlinks t)

;; Save backup files in centralised directory
(defvar backup-dir "~/.emacs.d/backups/")
(setq backup-directory-alist (list (cons "." backup-dir)))

;; Display settings
(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-light t t)
  (load-theme 'solarized-dark t t))

(use-package purple-haze-theme
  :ensure t
  :config
  (load-theme 'purple-haze t t))

(use-package atom-one-dark-theme
  :ensure t
  :config
  (load-theme 'atom-one-dark t t))

(use-package spacemacs-theme
  :ensure t
  :config
  (load-theme 'spacemacs-dark t t)
  (load-theme 'spacemacs-light t))

;; custom configuration
(require 'start-server)
(require 'general)
(require 'writing)
(require 'init-org)
(require 'init-powerline)
(require 'init-magit)
(require 'ruby)
(require 'web)
(require 'init-evil)
(require 'init-ag)
(require 'init-ivy)
;; (require 'init-ido)
;; (require 'init-helm)
(require 'init-shell)

;;;;;;;;;;;; Customization variables ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "nil" :slant normal :weight normal :height 181 :width normal)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(ivy-mode t))
