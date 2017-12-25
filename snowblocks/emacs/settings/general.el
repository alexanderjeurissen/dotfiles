(use-package ace-jump-mode
  :ensure t
  :init
  (autoload 'ace-jump-mode "ace-jump-mode" nil t)
  (evil-leader/set-key "<SPC>" 'ace-jump-mode))

(use-package ace-window
  :ensure t
  :config
  (setq aw-keys '(?a ?o ?e ?u ?h ?t ?n ?s ?i ?d)))

;; (use-package switch-window
;;   :ensure t
;;   :config
;;   (defcustom switch-window-qwerty-shortcuts
;;     '("a" "o" "e" "u" "i" "d" "h" "t" "n" "s" "1" "2" "3" "4" "5" "6")
;;     "hack take make it work with my custom keyboard that is hard coded dvorak"
;;     :type 'list
;;     :group 'switch-window)
;;   (setq switch-window-shortcut-style 'qwerty))
  
(use-package golden-ratio
  :ensure t
  :config
  (golden-ratio-mode 1)
  ;; Fix for evil-mode and ace-window
  ;; see issue on github:
  ;; https://github.com/roman/golden-ratio.el/issues/57
  (defvar golden-ratio-selected-window
    (frame-selected-window)
    "Selected window.")

  (defun golden-ratio-set-selected-window
      (&optional window)
    "Set selected window to WINDOW."
    (setq-default
      golden-ratio-selected-window (or window (frame-selected-window))))

  (defun golden-ratio-selected-window-p
      (&optional window)
    "Return t if WINDOW is selected window."
    (eq (or window (selected-window))
        (default-value 'golden-ratio-selected-window)))

  (defun golden-ratio-maybe
      (&optional arg)
    "Run `golden-ratio' if `golden-ratio-selected-window-p' returns nil."
    (interactive "p")
    (unless (golden-ratio-selected-window-p)
      (golden-ratio-set-selected-window)
      (golden-ratio arg)))

  (add-hook 'buffer-list-update-hook #'golden-ratio-maybe)
  (add-hook 'focus-in-hook           #'golden-ratio)
  (add-hook 'focus-out-hook          #'golden-ratio))

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

;; remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(provide 'general)
