(el-get-bundle lsp-mode)
(el-get-bundle racer)
(el-get-bundle rustic)


(setq auto-mode-alist (cl-remove "\\.rs\\'" auto-mode-alist :test 'equal :key 'car))
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rustic-mode))

(add-hook 'rustic-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(define-key rustic-mode-map (kbd "TAB") #'company-indent-or-complete-common)

(setq company-tooltip-align-annotations t)

(setq racer-command-timeout 0)
(setq racer-eldoc-timeout 0.5)


(setq-default rustic-format-trigger 'on-save)
