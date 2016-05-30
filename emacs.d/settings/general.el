(use-package ace-jump-mode
  :ensure t
  :init
  (autoload 'ace-jump-mode "ace-jump-mode" nil t)
  (evil-leader/set-key "<SPC>" 'ace-jump-mode))

 (use-package company
  :ensure t
  :defer t
  :init
  (global-company-mode)
  :config
  (setq company-idle-delay 0.2)
  (setq company-selection-wrap-around t)
  (define-key company-active-map [tab] 'company-complete)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))   

(provide 'general)
