(require 'uniquify)
;; filename<dir>の形式のバッファ名にする
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
;; *で囲まれたバッファ名は対象外にする
(setq uniquify-igonre-buffers-re "*[^*]+*")