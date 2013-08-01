;; ====================================
;; バックアップファイルを一ヶ所にまとめる
;; ====================================
(setq make-backup-files nil)
(setq make-backup-files t)
(setq backup-directory-alist
  (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
    backup-directory-alist))
