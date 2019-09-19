(el-get-bundle python)
(el-get-bundle py-yapf)
(el-get-bundle jedi)

(add-to-list 'auto-mode-alist '("\\\.py\\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(defun tnoda/turn-on-flycheck-mode ()
  (flycheck-mode 1))
(add-hook 'python-mode-hook 'tnoda/turn-on-flycheck-mode)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(add-hook 'python-mode-hook 'py-yapf-enable-on-save)

(setq python-indent-offset 4)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-python-flake8-executable nil)
 '(py-python-command "python3")
 '(flycheck-python-flake8-executable "python3")
 '(flycheck-python-pycompile-executable "python3")
 '(flycheck-python-pylint-executable "python3")
)
