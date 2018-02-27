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
(when (member "FuraCode Nerd Font" (font-family-list))
  (set-fontset-font t 'unicode "FuraCode Nerd Font-24" nil 'prepend)
  (set-fontset-font t 'default "FuraCode Nerd Font-14" nil 'prepend))

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
  (setq solarized-use-variable-pitch nil)
  (setq solarized-height-plus-1 1.0)
  (setq solarized-height-plus-2 1.0)
  (setq solarized-height-plus-3 1.0)
  (setq solarized-height-plus-4 1.0)
  (setq solarized-high-contrast-mode-line t)
  (load-theme 'solarized-light t t)
  (load-theme 'solarized-dark t))

;; custom configuration
(require 'start-server)
(require 'general)
(require 'writing)
(require 'init-org)
;;(require 'init-powerline)
(require 'init-magit)
(require 'ruby)
(require 'web)
;; (require 'init-evil)
(require 'init-ag)
(require 'init-ivy)
;; (require 'init-ido)
;;(require 'init-helm)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ivy-rich exec-path-from-shell ivy-hydra counsel-osx-app counsel-projectile counsel ivy yasnippet yard-mode writeroom-mode wgrep-ag web-mode wc-mode use-package solarized-theme smex smart-mode-line rspec-mode rainbow-mode purple-haze-theme projectile-rails org-bullets nyan-mode golden-ratio flycheck evil-org evil-magit diff-hl company atom-one-dark-theme ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
