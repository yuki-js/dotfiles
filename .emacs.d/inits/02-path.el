;; set path for /usr/local/bin
(let ((path "/usr/local/bin"))
  (setq exec-path (cons path exec-path))
  (setenv "PATH" (concat (concat path path-separator) (getenv "PATH")))
  )

(let ((path "/usr/local/texlive/2021basic/bin/universal-darwin"))
  (setq exec-path (cons path exec-path))
  (setenv "PATH" (concat (concat path path-separator) (getenv "PATH")))
  )
