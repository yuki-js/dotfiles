(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

;; set path for nodebrew
(let ((path (concat (getenv "HOME") "/.nodebrew/current/bin")))
  (setq exec-path (cons path exec-path))
  
  (setenv "PATH" (concat (concat path path-separator) (getenv "PATH")))
  )

;; set path for /usr/local/bin
(let ((path "/usr/local/bin"))
  (setq exec-path (cons path exec-path))
  
  (setenv "PATH" (concat (concat path path-separator) (getenv "PATH")))
  ) 
;; set path for /Users/yjsnpi/.cargo/bin
(let ((path "/Users/yjsnpi/.cargo/bin"))
  (setq exec-path (cons path exec-path))
  
  (setenv "PATH" (concat (concat path path-separator) (getenv "PATH")))
  ) 
