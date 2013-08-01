(require 'direx)

;; direx:direx-modeのバッファをウィンドウ左辺に幅25でポップアップ
;; :dedicatedにtを指定することで、direxウィンドウ内でのバッファの切り替えが
;; ポップアップ前のウィンドウに移譲される
(push '(direx:direx-mode :position left :width 30 :dedicated t)
      popwin:special-display-config)

(defun direx:direx-elscreen-new-window ()
  (interactive)
  (direx:find-item-other-window)
  (elscreen-split)
  )

(add-hook 'direx:direx-mode-hook
	  (lambda()
	    (define-key direx:direx-mode-map "o" 'direx:direx-elscreen-new-window)
	    )
	  )
