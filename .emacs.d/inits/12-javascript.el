(el-get-bundle js2-mode)
(el-get-bundle tern)
(el-get-bundle tern-auto-complete)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(eval-after-load 'tern
  '(progn
    (require 'tern-auto-complete)
    (tern-ac-setup)))



(add-hook 'js2-mode-hook
    (lambda ()
      (tern-mode t)))

(custom-set-variables

 '(js-indent-level 2)
 '(js-switch-indent-offset 2)
 '(js2-include-node-externs t)
 '(js2-indent-switch-body t)
 '(js2-missing-semi-one-line-override t)
 '(js2-mode-assume-strict t)
 '(js2-strict-missing-semi-warning nil)

 )
