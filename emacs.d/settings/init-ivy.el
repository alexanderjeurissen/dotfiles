(use-package smex
  :ensure t)

(use-package dash
  :ensure t)

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-height 10)
  (setq ivy-count-format "(%d/%d) ")
  (setq projectile-completion-system 'ivy)
  (setq magit-completing-read-function 'ivy-completing-read))

(use-package counsel
  :ensure t
  :config
  (use-package counsel-projectile
    :ensure t))

(provide 'init-ivy)
