(autoload 'scss-mode "scss-mode")
(setq scss-compile-at-save nil) ;; 自動コンパイルをオフにする

;; (require 'flymake-sass)
;; (add-hook 'sass-mode-hook 'flymake-sass-load)
;; (add-hook 'scss-mode-hook 'flymake-sass-load)

;; ;; CSS
(defun my-css-electric-pair-brace ()
  (interactive)
  (insert "{")(newline-and-indent)
  (newline-and-indent)
  (insert "}")
  (indent-for-tab-command)
  (previous-line)(indent-for-tab-command)
  )

(defun my-colon-space ()
  (interactive)
  (insert ":")
  (insert " ")
  (insert ";")
  (backward-char)
  )
  ;; (newline-and-indent))

;; ;; scss-mode
;; ;; https://github.com/antonj/scss-mode
(autoload 'scss-mode "scss-mode")
;; (add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(add-to-list 'auto-mode-alist '("\\.\\(scss\\|css\\)\\'" . scss-mode))
(add-hook 'scss-mode-hook 'ac-css-mode-setup)
(add-hook 'scss-mode-hook
          (lambda ()
            (define-key scss-mode-map "\M-{" 'my-css-electric-pair-brace)
            (define-key scss-mode-map ":" 'my-colon-space)
            (setq css-indent-offset 2)
            (setq scss-compile-at-save nil)
            (setq ac-sources '(
                               ac-source-words-in-all-buffer
                               ac-source-dictionary
                               ))            
            ))
(add-to-list 'ac-modes 'scss-mode)

(load "brackets.el")
(add-hook 'scss-mode-hook
          '(lambda()
             (progn
               (define-key scss-mode-map "{" 'insert-braces)
               (define-key scss-mode-map "(" 'insert-parens)
               (define-key scss-mode-map "\"" 'insert-double-quotation)
               (define-key scss-mode-map "'" 'insert-single-quotation)
               (define-key scss-mode-map "[" 'insert-brackets)
               (define-key scss-mode-map "\C-c}" 'insert-braces-region)
               (define-key scss-mode-map "\C-c)" 'insert-parens-region)
               (define-key scss-mode-map "\C-c]" 'insert-brackets-region)
               (define-key scss-mode-map "\C-c\"" 'insert-double-quotation-region)
	       (define-key scss-mode-map "'" 'insert-single-quotation-region))))


