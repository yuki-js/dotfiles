(el-get-bundle lsp-mode)
(el-get-bundle racer)
(el-get-bundle flycheck)
(el-get-bundle rust-mode)
(el-get-bundle xterm-color)
(el-get-bundle projectile)
(el-get-bundle rustic)

(add-hook 'rust-mode-hook (lambda ()
                             (rustic-mode)
                             (setq auto-mode-alist (cl-remove "\\.rs\\'" auto-mode-alist :test 'equal :key 'car))
                             (add-to-list 'auto-mode-alist '("\\.rs\\'" . rustic-mode))
                             ))

(add-hook 'rustic-mode-hook (lambda()
                              (push 'rustic-clippy flycheck-checkers)
                              (setq racer-command-timeout 0)
                              (setq rustic-format-trigger 'on-save)
                              (racer-mode)))
(add-hook 'racer-mode-hook (lambda()
                             (setq racer-eldoc-timeout 0.5)
                             (eldoc-mode)
                             (company-mode)
                             (setq racer-rust-src-path "~/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/library")
                             ))

(define-key rustic-mode-map (kbd "TAB") #'company-indent-or-complete-common)



(setq rustic-lsp-format t)
(setq lsp-rust-analyzer-cargo-watch-command "clippy")
