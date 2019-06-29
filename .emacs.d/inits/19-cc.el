(add-hook 'c-mode-common-hook 'flycheck-mode)
(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-clang-include-path
                           (list "/usr/local/include"))))
