;;====================================
;; imenu
;;====================================
(require 'imenu)
(require 'imenu-tree)
(require 'cl)

(which-function-mode 1)

(defun web-imenu-create-index ()
  (let ((index))
    (goto-char (point-min))
    (while (re-search-forward "\\(id\\|class\\)=\"\\([^\"]+\\)\"" nil t)
      (push (cons (concat
                   (if (equal "id" (match-string 1)) "#" ".")
                   (match-string 2)) (match-beginning 1)) index))
    (nreverse index)))

(add-hook 'web-mode-hook
          '(lambda ()
             (setq imenu-create-index-function 'web-imenu-create-index)))

;; (autoload 'html-imenu-setup "html-imenu")
;; (add-hook 'web-mode-hook 'html-imenu-setup)



;; (key-chord-define-global "fd" 'anything-imenu)
