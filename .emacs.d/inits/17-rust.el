(el-get-bundle rust-mode)
(el-get-bundle racer)
(el-get-bundle lsp-mode)

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'rust-mode-hook #'company-mode)
(add-hook 'racer-mode-hook
          (lambda () (local-set-key (kbd "TAB") #'company-complete)))


