;; C言語
(setq c-mode-common-hook
      '(lambda ()
         (let ()
           (c-set-offset 'statement-cont 'c-lineup-math)
           )))

(load "brackets.el")
(add-hook 'c-mode-hook
          '(lambda()
             (progn
               (define-key c-mode-map "{" 'insert-braces)
               (define-key c-mode-map "(" 'insert-parens)
               (define-key c-mode-map "\"" 'insert-double-quotation)
               (define-key c-mode-map "'" 'insert-single-quotation)
               (define-key c-mode-map "[" 'insert-brackets)
               (define-key c-mode-map "\C-c}" 'insert-braces-region)
               (define-key c-mode-map "\C-c)" 'insert-parens-region)
               (define-key c-mode-map "\C-c]" 'insert-brackets-region)
               (define-key c-mode-map "\C-c\"" 'insert-double-quotation-region))))

