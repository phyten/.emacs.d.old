;; グリングリン移動
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-vertically))
  (other-window 1))

(global-set-key (kbd "M-t") 'other-window-or-split)
(global-set-key (kbd "C-t") 'other-window-or-split)

;; windowを分けても折り返す
(setq truncate-partial-width-windows nil)

;;画面最大化
(defun mac-toggle-max-window ()
  (interactive)
  (if (frame-parameter nil 'fullscreen)
      (set-frame-parameter nil 'fullscreen nil)
    (set-frame-parameter nil 'fullscreen 'fullboth)))
(setq mac-autohide-menubar-on-maximize nil)

(custom-set-variables
 '(display-time-mode t)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))
(custom-set-faces)
