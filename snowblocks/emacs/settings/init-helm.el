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
    :commands (helm-projectile helm-projectile-find-files helm-projectile-switch-project)
    :ensure t)
  (helm-mode 1)
  (helm-flx-mode 1)
  (helm-fuzzier-mode 1)

  ;; show helm-window in current split
  (setq helm-split-window-in-side-p t)
  (setq helm-swoop-split-with-multiple-windows t)

  ;; evil mappings
  ; (evil-leader/set-key
  ;   "f"  'helm-find-files
  ;   "b"  'switch-to-buffer
  ;   "/"  'helm-ag
  ;   "pf" 'helm-projectile-find-files
  ;   "/"  'helm-projectile-ag
  ;   "x"  'helm-M-x))
)
(provide 'init-helm)
