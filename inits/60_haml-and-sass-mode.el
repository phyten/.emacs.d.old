;; ====================================
;; haml, saas
;; ====================================

;; highlight-indentation
(require 'highlight-indentation)
;; インデントのハイライト
(set-face-background 'highlight-indentation-current-column-face "#444444")
(setq highlight-indentation-offset 2)

;; slim-mode
(require 'slim-mode)

;;haml-mode
(require 'haml-mode)
;;sass-mode
;; (require 'sass-mode)
;; (add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))
;; (require 'flymake-sass)
;; (add-hook 'scss-mode-hook 'flymake-sass-load)
