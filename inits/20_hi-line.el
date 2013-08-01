;; (defface hlline-face
;;   '((((class color)
;;       (background dark))
;;      (:background "blue" :foreground "white"))
;;     (((class color)
;;       (background light))
;;      (:background "ForestGreen"))
;;     (t
;;      ()))
;;   "*Face used by hl-line.")
;; (setq hl-line-face 'hlline-face)

;; (setq hl-line-face 'hiline-face)
;; (global-hl-line-mode)
(global-hl-line-mode t)
(setq hl-line-face 'underline)
