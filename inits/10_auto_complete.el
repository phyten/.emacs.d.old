(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(add-to-list 'ac-sources 'ac-source-yasnippet)
;; (add-to-list 'ac-source-yasnippet "~/.emacs.d/snippets")
(require 'auto-complete-config)
(ac-config-default)
;; (define-key ac-mode-map (kbd "M-i") 'ac-complete-yasnippet)
;; (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
(ac-set-trigger-key "\M-i")
(setq ac-dwim t)  ; 空気読んでほしい
(setq ac-auto-start 4)                         ; 4 文字以上で起動
(setq ac-auto-show-menu 0.5)                   ; 0.5秒でメニュー表示
(setq ac-use-comphist t)                       ; 補完候補をソート
(setq ac-candidate-limit nil)                  ; 補完候補表示を無制限に
(setq ac-use-quick-help t)                     ; tool tip 無し
(setq ac-use-menu-map t)                       ; キーバインド
(define-key ac-menu-map (kbd "C-n")         'ac-next)
(define-key ac-menu-map (kbd "C-p")         'ac-previous)
;; (define-key ac-completing-map (kbd "<tab>")   'ac-stop)
(define-key ac-completing-map (kbd "RET") nil) ; return での補完禁止
(setq ac-auto-start nil)
(add-to-list 'ac-modes 'scss-mode)
(add-to-list 'ac-modes 'web-mode)
(add-to-list 'ac-modes 'coffee-mode)
(add-to-list 'ac-modes 'd-mode)
(add-to-list 'ac-modes 'ruby-mode)

