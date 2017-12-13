;; load server if not already started
(load "server")
(unless (server-running-p) (server-start))
(setq server-window 'pop-to-buffer)

(provide 'start-server)
