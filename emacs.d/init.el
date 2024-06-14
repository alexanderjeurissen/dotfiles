;; Set vc-follow-symlinks before any checks are made
(setq vc-follow-symlinks t)

;; Load the rest of the configuration from config.org
(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))
