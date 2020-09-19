(el-get-bundle dockerfile-mode)
(el-get-bundle docker-tramp)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
(require 'docker-tramp-compat)
