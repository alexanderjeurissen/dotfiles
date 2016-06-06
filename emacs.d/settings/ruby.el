(use-package rspec-mode
  :ensure t)

(use-package projectile-rails
  :ensure t
  :config

  (use-package evil-rails
    :ensure t
    :config
    (defgroup evil-rails nil
      "Evil Rails customizations."
      :prefix "evil-rails-"
      :group 'evil-rails)

    (evil-ex-define-cmd "A" 'projectile-toggle-between-implementation-and-test))

  ;; add key binds for easily searching for
  ;; models, controllers, migration etc.
  (evil-leader/set-key
    "rm"  'projectile-rails-find-model
    "rc"  'projectile-rails-find-controller
    "rs"  'projectile-rails-find-spec
    "rv"  'projectile-rails-find-view
    "rG"  'projectile-rails-generate
    "rM"  'projectile-rails-find-migration
    "rR"  'projectile-rails-goto-routes
    "rC"  'projectile-rails-console))

(use-package yard-mode
  :ensure t)

(use-package inf-ruby
  :ensure t
  :config
  (add-hook 'after-init-hook 'inf-ruby-switch-setup))

(require 'rcodetools)

;; enable several minor modes for ruby files including:
;; ya snippets, rspec, yard, flycheck(linting)
(add-hook 'ruby-mode-hook
          (lambda ()
            (setq ruby-insert-encoding-magic-comment nil)
            (yas-minor-mode)
            (rspec-mode)
            (yard-mode)
            (flycheck-mode)
            (local-set-key "\r" 'newline-and-indent)
            (setq rspec-command-options "--color --order random")
            (define-key ruby-mode-map (kbd "C-c C-c") 'xmp)
            (projectile-rails-mode)))

;; enable ruby-mode for additional buffers
(hrs/add-auto-mode
 'ruby-mode
 "\\Gemfile$"
 "\\.rake$"
 "\\.gemspec$"
 "\\Guardfile$"
 "\\Rakefile$")

;; scroll to first error when running rspec
(add-hook 'rspec-compilation-mode-hook
          (lambda ()
            (make-local-variable 'compilation-scroll-output)
            (setq compilation-scroll-output 'first-error)))

;; add pry-remote
;; copied from http://emacs.stackexchange.com/questions/3537/how-do-you-run-pry-from-emacs
(defun aj/run-remote-pry (&rest args)
  (interactive)
  (let ((buffer (apply 'make-comint "pry-remote" "pry-remote" nil args)))
    (switch-to-buffer buffer)
    (setq-local comint-process-echoes t)))

(define-key ruby-mode-map (kbd "C-c r d") 'aj/run-remote-pry)


(provide 'ruby)
