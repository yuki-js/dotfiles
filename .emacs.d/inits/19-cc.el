(el-get-bundle lsp-mode)
(el-get-bundle lsp-ui)
(el-get-bundle company-lsp)
(add-hook 'c-mode-common-hook 'flycheck-mode)
(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-clang-include-path
                           (list "/usr/local/include"))))
(add-hook 'c-mode-common-hook #'lsp)
(add-hook 'c-mode-common-hook 'company-mode) 
