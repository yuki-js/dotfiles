(el-get-bundle vue-mode)



(add-hook 'vue-mode-hook
          (lambda ()
            (prettier-js-mode)
            (setq mmm-js-mode-enter-hook (lambda () (setq syntax-ppss-table nil)))
            (setq mmm-typescript-mode-enter-hook (lambda () (setq syntax-ppss-table nil)))
            (setq mmm-css-mode-enter-hook (lambda () (setq syntax-ppss-table nil)))
            ))
