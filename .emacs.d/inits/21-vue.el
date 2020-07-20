(el-get-bundle vue-mode)

(add-hook 'vue-mode-hook
          (lambda ()
            (prettier-js-mode)))
