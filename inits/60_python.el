;; pymacs
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
;; (eval-after-load "pymacs"
;;   '(add-to-list 'pymacs-load-path "YOUR-PYMACS-DIRECTORY"))
;; python-mode, pycomplete 
;; (setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
;; (setq interpreter-mode-alist (cons '("python" . python-mode)
;;                                    interpreter-mode-alist))
;; (autoload 'python-mode "python-mode" "Python editing mode." t)
;; (add-hook 'python-mode-hook '(lambda ()
;;                                (require 'pycomplete)
;;                                ))


(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
				   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

;; All languages:
;; (setq skeleton-pair t)
;; (global-set-key "(" 'skeleton-pair-insert-maybe)
;; (global-set-key "[" 'skeleton-pair-insert-maybe)
;; (global-set-key "{" 'skeleton-pair-insert-maybe)
;; (global-set-key "\"" 'skeleton-pair-insert-maybe)
;; (global-set-key "'" 'skeleton-pair-insert-maybe)

;; Just python
;; (add-hook 'python-mode-hook 
;; 	  (lambda () 
;; 	    (define-key python-mode-map "'" 'skeleton-pair-insert-maybe)))


;; (load "brackets.el")
;; (add-hook 'python-mode-hook
;;           '(lambda()
;;              (progn
;;                (define-key python-mode-map "{" 'insert-braces)
;;                (define-key python-mode-map "(" 'insert-parens)
;;                (define-key python-mode-map "\"" 'insert-double-quotation)
;;                (define-key python-mode-map "'" 'insert-single-quotation)
;;                (define-key python-mode-map "[" 'insert-brackets)
;;                (define-key python-mode-map "\C-c}" 'insert-braces-region)
;;                (define-key python-mode-map "\C-c)" 'insert-parens-region)
;;                (define-key python-mode-map "\C-c]" 'insert-brackets-region)
;;                (define-key python-mode-map "\C-c\"" 'insert-double-quotation-region)
;; 	       (define-key python-mode-map "'" 'insert-single-quotation-region))))

;; (load-file "~/.emacs.d/site-lisp/emacs-for-python/epy-init.el")
