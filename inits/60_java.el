;; (load "cedet")
;; (load "jde")
;; (setq jde-web-browser "BROWSER")
;; (setq jde-doc-dir "JDK DIRECTORY")
;; (jde-db-set-source-paths "SRCPTH1;SRCPTH2;...")

(load "brackets.el")
;; (require 'parenthesis)
;; (add-hook
;;  'java-mode-hook
;;  '(lambda()
;;     (parenthesis-register-keys "{('\"[" java-mode-map)))

(add-hook 'java-mode-hook
          '(lambda()
             (progn
               (define-key java-mode-map "{" 'insert-braces)
               (define-key java-mode-map "(" 'insert-parens)
               (define-key java-mode-map "\"" 'insert-double-quotation)
               (define-key java-mode-map "'" 'insert-single-quotation)
               (define-key java-mode-map "[" 'insert-brackets)
               (define-key java-mode-map "\C-c}" 'insert-braces-region)
               (define-key java-mode-map "\C-c)" 'insert-parens-region)
               (define-key java-mode-map "\C-c]" 'insert-brackets-region)
               (define-key java-mode-map "\C-c\"" 'insert-double-quotation-region))))

