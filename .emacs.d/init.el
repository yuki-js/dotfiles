(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

(el-get-bundle emacs-jp/init-loader)

;; bytecompile init-loader
(setq init-loader-byte-compile nil)

;; show logs only when error occurs
(setq init-loader-show-log-after-init 'error-only)

(init-loader-load "~/.emacs.d/inits")
