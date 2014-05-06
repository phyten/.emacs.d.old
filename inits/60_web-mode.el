(require 'web-mode)

;;; emacs 23以下の互換
(when (< emacs-major-version 24)
  (defalias 'prog-mode 'fundamental-mode))

;;; 適用する拡張子
(add-to-list 'auto-mode-alist '("\\.phtml$"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x$"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.html.erb$"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?$"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl?$"     . web-mode))

(setq web-mode-engines-alist
      '(("angular"    . "\\.html\\'")  
        ("template-toolkit"    . "\\.tpl\\'")
        ("php"    . "\\.phtml\\'"))
)

;;; インデント数
(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-html-offset   2)
  (setq web-mode-css-offset    2)
  (setq web-mode-script-offset 2)
  (setq web-mode-php-offset    2)
  (setq web-mode-java-offset   2)
  (setq web-mode-asp-offset    2))
(add-hook 'web-mode-hook 'web-mode-hook)

(define-key web-mode-map (kbd "C-c C-n") 'web-mode-element-end)
(define-key web-mode-map (kbd "C-c C-p") 'web-mode-element-beginning)
(define-key web-mode-map (kbd "C-c C-k") 'web-mode-element-kill)

(sp-with-modes '(web-mode)
  (sp-local-pair "IF" "END"
                 :unless '(sp-in-string-or-word-p)
                 :post-handlers '(
                                  (space-and-space-on-each-side "SPC")
                                  (space-on-each-side "=" "#")
                                  ))
  (sp-local-pair "UNLESS" "END"
                 :unless '(sp-in-string-or-word-p)
                 :post-handlers '(
                                  (space-and-space-on-each-side "SPC")
                                  (space-on-each-side "=" "#")
                                  ))
  (sp-local-pair "FOREACH" "END"
                 :unless '(sp-in-string-or-word-p)
                 :post-handlers '(
                                  (space-and-space-on-each-side "SPC")
                                  (space-on-each-side "=" "#")
                                  ))
  (sp-local-pair "WHILE" "END"
                 :unless '(sp-in-string-or-word-p)
                 :post-handlers '(
                                  (space-and-space-on-each-side "SPC")
                                  (space-on-each-side "=" "#")
                                  ))
  (sp-local-pair "WHILE" "END"
                 :unless '(sp-in-string-or-word-p)
                 :post-handlers '(
                                  (space-and-space-on-each-side "SPC")
                                  (space-on-each-side "=" "#")
                                  ))

  )
