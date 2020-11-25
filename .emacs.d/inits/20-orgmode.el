(el-get-bundle org)

(setq org-latex-create-formula-image-program 'dvipng)
(setq org-html-validation-link nil)
(setq org-confirm-babel-evaluate nil)
(el-get-bundle ob-ipython)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ipython . t)
   ;; other languages..
   ))
