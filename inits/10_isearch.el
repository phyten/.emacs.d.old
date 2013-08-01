;; C-hでバックスペースがisearch内でも効くように
(define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)

;; isearch改良
(define-key isearch-mode-map "\C-q" 'my-isearch-backword)
(defun my-isearch-backword()
  "iserch中の先方単語削除"
  (interactive)
  (let ((len (length isearch-string)))
    (if (= 0 len)
        (ding)
      (setq isearch-string (replace-regexp-in-string "\\w+$" "" isearch-string))
      (if (= len (length isearch-string))
          (setq isearch-string (replace-regexp-in-string "\\W+$" "" isearch-string)))
      (setq isearch-message (mapconcat 'isearch-text-char-description isearch-string ""))))
  (if isearch-other-end (goto-char isearch-other-end))
  (isearch-search)
  (isearch-push-state)
  (isearch-update))

(define-key isearch-mode-map "\C-w" 'my-isearch-clear)
(defun my-isearch-clear()
  "isearch文字列の消去"
  (interactive)
  (setq isearch-string "")
  (setq isearch-message (mapconcat 'isearch-text-char-description isearch-string ""))
  (if isearch-other-end (goto-char isearch-other-end))
  (isearch-search)
  (isearch-push-state)
  (isearch-update))
