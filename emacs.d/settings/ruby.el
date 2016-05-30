(use-package enh-ruby-mode
  :ensure t
  :config
    (autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
    (add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))

    (add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

    (setq enh-ruby-bounce-deep-indent t)
    (setq enh-ruby-hanging-brace-indent-level 2))
