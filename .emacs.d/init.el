(el-get-bundle emacs-jp/init-loader)

;; bytecompile init-loader
(setq init-loader-byte-compile t)

;; show logs only when error occurs
(setq init-loader-show-log-after-init 'error-only)

(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js-indent-level 2)
 '(js-switch-indent-offset 2)
 '(js2-include-node-externs t)
 '(js2-indent-switch-body t)
 '(js2-missing-semi-one-line-override t)
 '(js2-mode-assume-strict t)
 '(js2-strict-missing-semi-warning nil)
 '(markdown-command "multimarkdown")
 '(package-selected-packages '(dashboard vue-mode org rustic racer company))
 '(rustic-format-trigger 'on-save))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
