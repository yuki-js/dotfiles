(el-get-bundle rjsx-mode)
(el-get-bundle tern)
(el-get-bundle auto-complete)
(el-get-bundle tern-auto-complete)

(add-hook 'rjsx-mode-hook (lambda () (tern-mode t)))

(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))

(add-hook 'rjsx-mode-hook
          (lambda ()
            (tern-mode t)
            (auto-complete-mode)
            (tern-ac-setup)
            (prettier-js-mode)))

(setq js-indent-level 2)
(setq js-switch-indent-offset 2)
(setq js2-include-node-externs t)
(setq js2-indent-switch-body t)
(setq js2-missing-semi-one-line-override t)
(setq js2-mode-assume-strict t)
(setq js2-strict-missing-semi-warning nil)
