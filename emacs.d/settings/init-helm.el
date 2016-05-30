(use-package helm
  :ensure t
  :config
  (use-package helm-swoop
    :ensure t)
  (use-package helm-flx
    :ensure t)
  (use-package helm-fuzzier
    :ensure t)
  (use-package smex
    :ensure t)
  (use-package dash
    :ensure t)
  (use-package helm-ag
    :commands (helm-ag helm-ag-buffers helm-ag-project-root helm-ag-this-file)
    :ensure t)
  (use-package helm-projectile
    :commands (helm-projectile helm-projectile-switch-project)
    :ensure t)
  (helm-mode 1)
  (helm-flx-mode 1)
  (helm-fuzzier-mode 1))

(provide 'init-helm)
