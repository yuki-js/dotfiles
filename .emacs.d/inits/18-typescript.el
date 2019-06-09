(el-get-bundle typescript-mode)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))

(el-get-bundle tide)

(setq typescript-indent-level 2)

(add-hook 'typescript-mode-hook
          (lambda ()
            (interactive)
            (tide-setup)
            (flycheck-mode +1)
            (setq flycheck-check-syntax-automatically '(save mode-enabled))
            (eldoc-mode +1)
            (tide-hl-identifier-mode +1)
            (company-mode +1)
            (global-set-key (kbd "M-*") 'tide-jump-back)))

(add-hook 'before-save-hook 'tide-format-before-save)
