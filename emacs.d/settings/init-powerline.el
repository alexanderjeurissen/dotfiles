(defface my-pl-segment-active
  '((t (:foreground "#00262f" :background "#889797")))
  "Powerline segment active face.")
(defface my-pl-segment-inactive
  '((t (:foreground "#889797" :background "#00262f")))
  "Powerline segment inactive face.")

(use-package smart-mode-line
  :ensure t
  :config
  (setq sml/theme 'respectful)
  (add-to-list 'sml/replacer-regexp-list
             '("^~/Git/\\(\\w+\\)/"
               (lambda (s) (concat ":" (upcase (match-string 1 s)) ":")))
             t)
  (sml/setup))

  (use-package nyan-mode
    :ensure t
    :config
    (nyan-mode 1))

(provide 'init-powerline)
