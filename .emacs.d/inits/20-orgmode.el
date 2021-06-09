(el-get-bundle org)
(setq org-latex-create-formula-image-program 'dvipng)
(setq org-html-validation-link nil)
(setq org-confirm-babel-evaluate nil)
(setenv "LANG" "ja_JP.UTF-8")
(setq org-latex-pdf-process
      '("lualatex -shell-escape -interaction nonstopmode %f"
        "lualatex -shell-escape -interaction nonstopmode %f")) 
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
 (shell . t)
   ;; other languages..
))
