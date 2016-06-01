(use-package writeroom-mode
  :ensure t)

(use-package wc-mode
  :ensure t)

(add-hook 'writeroom-mode-hook 'wc-mode)

(provide 'writing)
