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

  (defun my/newline_before (times)
    "insert a newline(s) above the current cursor position"
    (interactive)
    (save-excursion
      (move-beginning-of-line 1)
      (newline times)))

  (defun my/newline_after (times)
    "insert a newline(s) below the current cursor position"
    (interactive)
    (save-excursion
      (move-beginning-of-line nil)
      (newline times)))

  (defun my/toggle-comment (region)
    "comment or uncomment current line"
    (interactive)
    (comment-or-uncomment-region region))

  ;; move to beginning and end of line with capital H and L
  (define-key evil-normal-state-map (kbd "H") 'move-beginning-of-line)
  (define-key evil-normal-state-map (kbd "L") 'move-end-of-line)
  (define-key evil-visual-state-map (kbd "H") 'move-beginning-of-line)
  (define-key evil-visual-state-map (kbd "L") 'move-end-of-line)

  ;; Create new lines above/below current line
  (define-key evil-normal-state-map (kbd "go") 'my/newline_after)
  (define-key evil-normal-state-map (kbd "gO") 'my/newline_before)

  ;; expand region in visual mode
  (define-key evil-visual-state-map (kbd "v") 'er/expand-region)

  ;; comment current line
  (define-key evil-normal-state-map (kbd "gc") 'my/toggle-comment-on-line))

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
      "b"  'helm-mini             ;; Switch to another buffer
      "f" 'helm-find-files       ;; find file
      "pf" 'projectile-find-files ;; find file
      "wz" 'delete-other-windows  ;; C-w o
      "wh" 'evil-window-left
      "wl" 'evil-window-right
      "wk" 'evil-window-up
      "wj" 'evil-window-down
      "wv" 'evil-window-vsplit
      "ws" 'evil-window-split
      "n"  'rename-file
      "/"  'helm-ag          ;; Ag search from project's root
      "x"  'helm-M-x
      "y"  'yank-to-x-clipboard
    ))

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  (use-package evil-indent-textobject
    :ensure t))

(provide 'init-evil)
