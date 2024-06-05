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
  :diminish ivy-mode
  :bind (("C-x b" . ivy-switch-buffer)
         ("C-x B" . ivy-switch-buffer-other-window)
         ("M-H"   . ivy-resume))
  :commands (ivy-mode ivy-read ivy-completing-read)
  :config
  (setq ivy-use-virtual-buffers t
        ivy-height 10
        ivy-count-format "(%d/%d) "
        ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
  (ivy-mode 1)
  (setq projectile-completion-system 'ivy)
  (setq magit-completing-read-function 'ivy-completing-read)


  (use-package ivy-rich
    :ensure t
    :config
    (ivy-set-display-transformer 'ivy-switch-buffer
                                 'ivy-rich-switch-buffer-transformer)
    (setq ivy-virtual-abbreviate 'full
          ivy-rich-switch-buffer-align-virtual-buffer t)
    (setq ivy-rich-path-style 'abbrev))

  (use-package swiper
    :ensure t
    :bind (("C-s" . swiper)
           ("C-. C-s" . swiper)
           ("C-. C-r" . swiper))
    :commands swiper-from-isearch
    :init
    (bind-key "C-." #'swiper-from-isearch isearch-mode-map)
    :config
    (bind-key "M-y" #'yank swiper-map)
    (bind-key "M-%" #'swiper-query-replace swiper-map)
    (bind-key "M-h" #'swiper-avy swiper-map)
    (bind-key "M-c" #'swiper-mc swiper-map))

  (use-package counsel
    :ensure t
    :diminish counsel-mode
    :bind (("M-x"     . counsel-M-x)
           ("C-h f"   . counsel-describe-function)
           ("C-h v"   . counsel-describe-variable))
    :config
    (use-package counsel-projectile ;; Use counsel with projectile
      :ensure t)
    (use-package counsel-osx-app ;; use Ivy to launch osx apps
      :ensure t)
    (counsel-mode 1))

  (use-package ivy-hydra
    :ensure t)
  )
(provide 'init-ivy)
