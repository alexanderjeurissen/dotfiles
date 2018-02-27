;; Ivy, Swiper and Ido configuration
;; Used for fuzzy searching, and file exploration

(use-package smex
  :ensure t
  :config
  (setq smex-completion-method 'ivy))

(use-package dash
  :ensure t)

(use-package ido-occasional
  :ensure t)

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-height 10
        ivy-count-format "(%d/%d) "
        ivy-re-builders-alist '((t . ivy--regex-fuzzy)))

  (setq projectile-completion-system 'ivy)
  (setq magit-completing-read-function 'ivy-completing-read)

  (use-package counsel
    :ensure t
    :config
    (use-package counsel-projectile ;; Use counsel with projectile
      :ensure t)
    (use-package counsel-osx-app ;; use Ivy to launch osx apps
      :ensure t))

  (use-package ivy-hydra
    :ensure t)

  (global-set-key (kbd "C-s") 'swiper) ;; Use swiper instead of I-search
  (global-set-key (kbd "M-x") 'counsel-M-x) ;; Use Ivy for M-x
  (global-set-key (kbd "C-x C-f") 'counsel-find-file) ;; Use Ivy for finding files
  ; (evil-leader/set-key
  ;   "b"  'ivy-switch-buffer      ;; Switch to another buffer
  ;   "f"  'counsel-find-file      ;; find file
  ;   "/"  'counsel-ag             ;; use ag in none git repositories

  ;   "pf" 'projectile-find-file   ;; find file in git project
  ;   "p/" 'counsel-git-grep       ;; use git grep to locate file
  ;   "x"  'counsel-M-x))
  )
(provide 'init-ivy)
