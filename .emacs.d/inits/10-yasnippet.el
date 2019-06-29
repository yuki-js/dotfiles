(el-get-bundle yasnippet)
(el-get-bundle yasnippet-snippets)

(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"     ;; the default collection
        ))

(yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.
