(el-get-bundle elpy)
(elpy-enable)
(setq elpy-rpc-python-command "python3")
(elpy-use-ipython "python3")

(setq flycheck-python-flake8-executable "python3")
(setq flycheck-python-pycompile-executable "python3")
(setq flycheck-python-pylint-executable "python3")
(setq py-python-command "python3")
(setq python-shell-interpreter "python3")


(add-hook 'elpy-mode-hook (lambda ()
                            (add-hook 'before-save-hook
                                      'elpy-format-code nil t)))
