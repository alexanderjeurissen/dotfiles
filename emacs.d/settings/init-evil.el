;;;;;;;;;;; EVIL MODE Configuration

(defun my/configure-evil ()
  " Evil-mode customizations "

  ;; Use evil hjkl in occur mode
  (evil-add-hjkl-bindings occur-mode-map 'emacs
    (kbd "/")       'evil-search-forward
    (kbd "n")       'evil-search-next
    (kbd "N")       'evil-search-previous
    (kbd "C-d")     'evil-scroll-down
    (kbd "C-u")     'evil-scroll-up
    (kbd "C-w C-w") 'other-window)

  ;; use evil search module
  (setq evil-search-module 'evil-search)

  ;; move to beginning and end of line with capital H and L
  (define-key evil-normal-state-map (kbd "H") 'move-beginning-of-line)
  (define-key evil-normal-state-map (kbd "L") 'move-end-of-line)

  (define-key evil-visual-state-map (kbd "H") 'move-beginning-of-line)
  (define-key evil-visual-state-map (kbd "L") 'move-end-of-line)

  ;; Create new lines above/below current line
  (define-key evil-normal-state-map (kbd "go") 'aj/newline_after)
  (define-key evil-normal-state-map (kbd "gO") 'aj/newline_before)

  ;; expand region in visual mode
  (define-key evil-visual-state-map (kbd "v") 'er/expand-region)

  ;; comment current line
  (define-key evil-normal-state-map (kbd "gcc") 'hrs/comment-or-uncomment-region-or-line))

(use-package evil
  :ensure t
  :config
  (add-hook 'evil-mode-hook 'my/configure-evil)
  (evil-mode 1)

  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)
    (evil-leader/set-leader "<SPC>")
    (setq evil-leader/in-all-states 1)
    (evil-leader/set-key
      "b"  'ivy-switch-buffer    ;; Switch to another buffer
      "f"  'find-file            ;; find file
      "pf" 'projectile-find-file ;; find file
      "p/" 'counsel-git-grep     ;; use git grep to locate file
      "/"  'counsel-ag           ;; use ag in none git repositories
      "gs" 'magit-status         ;; git status
      "gl" 'magit-log            ;; git log
      "gb" 'magit-checkout       ;; git checkout
      "wz" 'delete-other-windows  ;; C-w o
      "q"  'hrs/kill-current-buffer
      "wc" 'quit-window
      "wh" 'evil-window-left
      "wl" 'evil-window-right
      "wk" 'evil-window-up
      "wj" 'evil-window-down
      "wv" 'evil-window-vsplit
      "ws" 'evil-window-split
      "n"  'rename-file
      "x"  'counsel-M-x
      "y"  'yank-to-x-clipboard
    ))

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  (use-package evil-search-highlight-persist
    :ensure t
    :config
    (global-evil-search-highlight-persist t))
    
  (use-package evil-indent-textobject
    :ensure t))

(provide 'init-evil)
