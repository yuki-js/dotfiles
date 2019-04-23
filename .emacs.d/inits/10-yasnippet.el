(el-get-bundle yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"     ;; the default collection
        "~/codes/yasnippet-snippets"
        ))

(yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.
