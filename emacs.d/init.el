(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(add-to-list 'load-path
             (expand-file-name "settings" user-emacs-directory))

;; Activate installed packages
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; custom configuration
(require 'general)
(require 'ruby)
(require 'init-evil)
(require 'init-ag)
(require 'init-helm)
(require 'init-shell)


;; list available fonts
;; (print (font-family-list))

;; specify font for all unicode characters
(when (member "SauceCodePro Nerd Font" (font-family-list))
  (set-fontset-font t 'unicode "SauceCodePro Nerd Font-20" nil 'prepend))

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

;; settings for fringe
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq-default left-fringe-width nil)
(setq-default indent-tabs-mode nil)

;; don't show warning for large files
(setq large-file-warning-threshold nil)
(setq split-width-threshold nil)

;; allow themes
(setq custom-safe-themes t)

;; Display settings
(use-package solarized-theme
:ensure t
:config
(load-theme 'solarized-light)
(load-theme 'solarized-dark t))


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
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default))))



