(el-get-bundle yatex :type git :url "https://www.yatex.org/gitbucket/yuuji/yatex.git" :branch "master")

;; force load file
;; why need i do that?
;; yatex must be in the path below
;; atama warui
(load-file "~/.emacs.d/el-get/yatex/yatex.el")

(add-to-list 'auto-mode-alist '("\\.tex\\'" . yatex-mode))
(setq tex-command "platex")
(setq bibtex-command "pbibtex")

;;reftex-mode
(add-hook 'yatex-mode-hook
          #'(lambda ()
              (reftex-mode 1)
              (define-key reftex-mode-map
                (concat YaTeX-prefix ">") 'YaTeX-comment-region)
              (define-key reftex-mode-map
                (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))


