;;====================================
;;色替え
;;====================================
;; (if window-system (progn
;;   ;; 文字の色を設定します。
;;   (add-to-list 'default-frame-alist '(foreground-color . "gray10"))
;;   ;; 背景色を設定します。
;;   (add-to-list 'default-frame-alist '(background-color . "#FFFDD4"))
;;   ;; カーソルの色を設定します。
;;   (add-to-list 'default-frame-alist '(cursor-color . "SlateBlue2"))
;;   ;; マウスポインタの色を設定します。
;;   (add-to-list 'default-frame-alist '(mouse-color . "SlateBlue2"))
;;   ;; モードラインの文字の色を設定します。
;;   (set-face-foreground 'modeline "white")
;;   ;; モードラインの背景色を設定します。
;;   (set-face-background 'modeline "MediumPurple2")
;;   ;; 選択中のリージョンの色を設定します。
;;   (set-face-background 'region "LightSteelBlue1")
;;   ;; モードライン（アクティブでないバッファ）の文字色を設定します。
;;   (set-face-foreground 'mode-line-inactive "gray30")
;;   ;; モードライン（アクテ;;   (set-face-background 'mode-line-inactive "gray85")
;; ))
;; (condition-case err
;;     (progn
;;       (require 'color-theme))
;;   (error (message "failed: %s" err)))
;; (color-theme-gnome2)
;(color-theme-gnome2)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
