(el-get-bundle org)
(setq org-latex-create-formula-image-program 'dvipng)
(setq org-html-validation-link nil)
(setq org-confirm-babel-evaluate nil)
(setenv "LANG" "ja_JP.UTF-8")
(setq org-latex-pdf-process
      '("lualatex -shell-escape -interaction nonstopmode %f"
        "lualatex -shell-escape -interaction nonstopmode %f")) 
(el-get-bundle ob-ipython)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ipython . t)
 (shell . t)
   ;; other languages..
))

(defun org-mode-reftex-setup ()
  (el-get-bundle reftex)
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
  )
(add-hook 'org-mode-hook 'org-mode-reftex-setup)
