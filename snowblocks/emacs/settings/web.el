(use-package web-mode
  :ensure t
  :config
  (use-package rainbow-mode
    :ensure t)

  ;; also enable rainbow-mode and rspec-mode when web-mode is active
  (add-hook 'web-mode-hook
            (lambda ()
              (rainbow-mode)
              (rspec-mode)
              (setq web-mode-markup-indent-offset 2)))

  ;; use web-mode for embedded files like rails templates or php
  (hrs/add-auto-mode
   'web-mode
   "\\.erb$"
   "\\.html$"
   "\\.php$"
   "\\.rhtml$"))

(provide 'web)
