(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(add-to-list 'ac-sources 'ac-source-yasnippet)
;; (add-to-list 'ac-source-yasnippet "~/.emacs.d/snippets")
(require 'auto-complete-config)
(ac-config-default)
;; (define-key ac-mode-map (kbd "M-i") 'ac-complete-yasnippet)
;; (ac-set-trigger-key "TAB")
(setq ac-auto-start t)

(add-to-list 'ac-modes 'scss-mode)
(add-to-list 'ac-modes 'web-mode)
(add-to-list 'ac-modes 'coffee-mode)

