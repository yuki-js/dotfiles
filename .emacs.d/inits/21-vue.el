(el-get-bundle ssass-mode)
(el-get-bundle edit-indirect)
(el-get-bundle mmm-mode)
(el-get-bundle vue-html-mode)
(el-get-bundle vue-mode)

(setq mmm-js-mode-enter-hook (lambda () (setq syntax-ppss-table nil)))
(setq mmm-typescript-mode-enter-hook (lambda () (setq syntax-ppss-table nil)))
(setq mmm-css-mode-enter-hook (lambda () (setq syntax-ppss-table nil)))

(add-hook 'vue-mode-hook
          (lambda ()
            (prettier-js-mode)
            
            ))
