(el-get-bundle rust-mode)
(el-get-bundle racer)
(el-get-bundle flycheck-rust)


(add-to-list 'exec-path (expand-file-name "~/.cargo/bin/"))

(eval-after-load "rust-mode"
  '(setq-default rust-format-on-save t))

(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)

(add-hook 'rust-mode-hook (lambda ()
                            (racer-mode)
                            (flycheck-rust-setup)))
;;; racerの補完サポートを使う
(add-hook 'racer-mode-hook (lambda ()
                             (company-mode)
                             (eldoc-mode)
                             ))
