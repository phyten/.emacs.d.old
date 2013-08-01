;;====================================
;; emacsのブックマーク
;;====================================
;; いやなブログ - Emacs のブックマークを自動保存
;; http://0xcc.net/blog/archives/000035.html
(defadvice bookmark-set (around bookmark-set-ad activate)
  (bookmark-load bookmark-default-file t t) ;; 登録前に最新のブックマークを読み直す
  ad-do-it
  (bookmark-save))
(defadvice bookmark-jump (before bookmark-set-ad activate)
  (bookmark-load bookmark-default-file t t))
