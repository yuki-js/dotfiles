(el-get-bundle emacs-jp/init-loader)

;; bytecompile init-loader
(setq init-loader-byte-compile nil)

;; show logs only when error occurs
(setq init-loader-show-log-after-init 'error-only)

(init-loader-load "~/.emacs.d/inits")
