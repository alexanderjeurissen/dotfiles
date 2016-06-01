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
  ;;(setq company-idle-delay 0.1)
  (setq company-selection-wrap-around t)
  (define-key company-active-map [tab] 'company-complete)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))   

(use-package yasnippet
  :ensure t)

(use-package flycheck
  :ensure t)

(use-package diff-hl
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
  (add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode))

(defun hrs/comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))

(defun aj/newline_before ()
  "insert a newline(s) above the current cursor position"
  (interactive)
  (save-excursion
    (move-beginning-of-line 1)
    (newline)))

(defun aj/newline_after ()
  "insert a newline(s) below the current cursor position"
  (interactive)
  (save-excursion
    (move-end-of-line 1)
    (newline)))

(defun hrs/kill-current-buffer ()
  "Kill the current buffer without prompting."
  (interactive)
  (kill-buffer (current-buffer)))

(defun hrs/add-auto-mode (mode &rest patterns)
  "Add entries to `auto-mode-alist' to use `MODE' for all given file `PATTERNS'."
  (dolist (pattern patterns)
    (add-to-list 'auto-mode-alist (cons pattern mode))))

(provide 'general)
