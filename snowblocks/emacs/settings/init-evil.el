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
  (define-key evil-normal-state-map (kbd "gcc") 'hrs/comment-or-uncomment-region-or-line)

  ;; scroll up ? no idea why this isn't enabled by default in evil
  (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)

  ;; set evil-shift-width to the same value as tab-width
  (setq evil-shift-width tab-width)

  ;; use gj and gk instead of j / k to move more easily between wrapped lines.
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line))

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
      "s"  'save-buffer

      "gs" 'magit-status           ;; git status
      "gl" 'magit-log              ;; git log
      "gc" 'magit-checkout         ;; git checkout
      "gb" 'magit-blame            ;; git blame current buffer

      "wz" 'delete-other-windows   ;; C-w o
      "q"  'hrs/kill-current-buffer

      "wt" 'ace-window
      "wc" 'evil-quit
      "wh" 'evil-window-left
      "wl" 'evil-window-right
      "wk" 'evil-window-up
      "wj" 'evil-window-down
      "wv" 'evil-window-vsplit
      "ws" 'evil-window-split

      "df" 'describe-function
      "dv" 'describe-variable
      "db" 'describe-bindings
      "dm" 'describe-mode
      "dp" 'describe-package

      "n"  'rename-file
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
