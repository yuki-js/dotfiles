;; 終了時にオートセーブファイルを削除する
(setq delete-auto-save-files t)
;; タブにスペースを使用する
(setq-default tab-width 2 indent-tabs-mode nil)
;;y or n
(fset 'yes-or-no-p 'y-or-n-p)
;; toolbarを消す
(tool-bar-mode 0)
;; beep音を消す
(defun my-bell-function ()
  (unless (memq this-command
        '(isearch-abort abort-recursive-edit exit-minibuffer
              keyboard-quit mwheel-scroll down up next-line previous-line
              backward-char forward-char))
    (ding)))
(setq ring-bell-function 'my-bell-function)

;; Don't open new frame when doubleclicking file.
(setq ns-pop-up-frames nil)

(when window-system (set-frame-size (selected-frame) 100 64))
;; auto close parenthesis
(electric-pair-mode 1)
;; don't create backup file
(setq make-backup-files nil)
