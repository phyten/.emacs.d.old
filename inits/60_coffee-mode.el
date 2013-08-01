(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(load "brackets.el")
(add-hook 'coffee-mode-hook
          '(lambda()
             (progn
               (define-key coffee-mode-map "{" 'insert-braces)
               (define-key coffee-mode-map "(" 'insert-parens)
               (define-key coffee-mode-map "\"" 'insert-double-quotation)
               (define-key coffee-mode-map "'" 'insert-single-quotation)
               (define-key coffee-mode-map "[" 'insert-brackets)
               (define-key coffee-mode-map "\C-c}" 'insert-braces-region)
               (define-key coffee-mode-map "\C-c)" 'insert-parens-region)
               (define-key coffee-mode-map "\C-c]" 'insert-brackets-region)
               (define-key coffee-mode-map "\C-c\"" 'insert-double-quotation-region))))

(defun coffee-custom ()
  "coffee-mode-hook"
  (and (set (make-local-variable 'tab-width) 2)
       (set (make-local-variable 'coffee-tab-width) 2))
  )

(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

;; 保存したとき､拡張子以外同名のjsバッファをリロードする
(defun revert-compiled-coffee ()
  (interactive)
  (with-current-buffer
      (concat (file-name-sans-extension (buffer-name (current-buffer))) ".js")
    (revert-buffer nil t)))
(add-hook 'coffee-mode-hook
          (lambda ()
            (add-hook 'after-save-hook 'revert-compiled-coffee nil t)))
