;;====================================
;; dired
;;====================================
(load "dired-x")
(add-hook 'dired-load-hook (lambda () (load "dired-x")))
;; wdired
; (autoload 'wdired-change-to-wdired-mode "wdired")
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
;; 今日変更されたファイルをハイライト
(defface my-face-f-2 '((t (:foreground "GreenYellow"))) nil)
(defvar my-face-f-2 'my-face-f-2)
(defun my-dired-today-search (arg)
  "Fontlock search function for dired."
  (search-forward-regexp
   (concat (format-time-string "%b %e" (current-time)) " [0-9]....") arg t))

(add-hook 'dired-mode-hook
          '(lambda ()
             (font-lock-add-keywords
              major-mode
              (list
               '(my-dired-today-search . my-face-f-2)
            ))))
;; いちいち新しいバッファを出さない
(add-hook 'dired-load-hook
          '(lambda ()
             (load-library "ls-lisp")
             (setq ls-lisp-dirs-first t)
             (setq dired-listing-switches "-AFl")
             (setq find-ls-option '("-exec ls -AFGl {} \\;" . "-AFGl"))
             (setq grep-find-command "find . -type f -print0 | xargs -0 -e grep -ns ")
             (require 'wdired)
             ))

;;別のディレクトリに行ったときもソート方法を保存する
(defadvice dired-advertised-find-file
  (around dired-sort activate)
  (let ((sw dired-actual-switches))
    ad-do-it
    (if (string= major-mode 'dired-mode)
        (progn
          (setq dired-actual-switches sw)
          (dired-sort-other dired-actual-switches)))
    ))

(defadvice dired-my-up-directory
  (around dired-sort activate)
  (let ((sw dired-actual-switches))
    ad-do-it
    (if (string= major-mode 'dired-mode)
        (progn
          (setq dired-actual-switches sw)
          (dired-sort-other dired-actual-switches)))
    ))

;;ディレクトリを最初に表示する
(setq insert-directory-program "gls")
(setq dired-listing-switches "-AFl --group-directories-first")
