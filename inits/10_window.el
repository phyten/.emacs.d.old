;; C-tでグリングリン移動
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-vertically))
  (other-window 1))

(global-set-key (kbd "C-t") 'other-window-or-split)

;; windowを分けても折り返す
(setq truncate-partial-width-windows nil)
