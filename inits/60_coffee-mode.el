(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

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

(require 'flymake-coffee)
(add-hook 'coffee-mode-hook 'flymake-coffee-load)
