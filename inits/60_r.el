;;====================================
;;R ess
;;====================================
(setq auto-mode-alist
(cons (cons "\\.r$" 'R-mode) auto-mode-alist))
(autoload 'R-mode "ess-site" "Emacs Speaks Statistics mode" t)

(defun ess:format-window-1 ()
  (split-window-horizontally))
(add-hook 'ess-pre-run-hook 'ess:format-window-1)

;; (require 'ess-R-object-popup)
;; (define-key 'ess-mode-map "\C-c\C-g" 'ess-R-object-popup)

;; (define-key 'ess-mode-map "\C-cr" 'anything-for-R)
;; (define-key 'inferior-ess-mode-map "\C-cr" 'anything-for-R)

;; (require 'auto-complete-acr)
