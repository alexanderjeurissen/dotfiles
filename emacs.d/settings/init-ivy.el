(use-package smex
  :ensure t
  :config
  (setq smex-completion-method 'ivy))

(use-package dash
  :ensure t)

(use-package swiper
  :Ensure t)

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-height 10)
  (setq ivy-count-format "(%d/%d) ")
  (setq projectile-completion-system 'ivy)
  (setq magit-completing-read-function 'ivy-completing-read)
  (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy))))

(use-package counsel
  :ensure t
  :config
  (use-package counsel-projectile
    :ensure t))

(define-key evil-normal-state-map (kbd "/") 'swiper) ;; I prefer the way swiper searches compared to evil

(evil-leader/set-key
  "b"  'ivy-switch-buffer      ;; Switch to another buffer
  "f"  'counsel-find-file      ;; find file
  "/"  'counsel-ag             ;; use ag in none git repositories

  "pf" 'projectile-find-file   ;; find file in git project
  "p/" 'counsel-git-grep       ;; use git grep to locate file

  "x"  'counsel-M-x)

(provide 'init-ivy)
