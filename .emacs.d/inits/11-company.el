(el-get-bundle company)
(setq company-tooltip-align-annotations t)
(company-quickhelp-mode +1)
(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)

(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
