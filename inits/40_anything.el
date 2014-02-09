;; ;;====================================
;; ;; anything.el
;; ;;====================================
;; (require 'anything-startup)
;; (require 'anything-c-shell-history)
;; (require 'anything-config)
;; (require 'anything-complete)
;; ;; (require 'semantic-imenu)
;; (setq anything-sources (list anything-c-source-buffers
;;                              anything-c-source-imenu
;;                              anything-c-source-recentf
;;                              anything-c-source-shell-history
;;                              anything-c-source-file-name-history
;;                              anything-c-source-locate))
;; (define-key anything-map (kbd "C-p") 'anything-previous-line)
;; (define-key anything-map (kbd "C-n") 'anything-next-line)
;; (define-key anything-map (kbd "C-v") 'anything-next-source)
;; (define-key anything-map (kbd "M-v") 'anything-previous-source)
;; (eval-after-load "anything"
;;   '(define-key anything-map (kbd "C-h") 'delete-backward-char))
;; ;; get past kill-ring pushing M-y (it is more convenient than normal mode)
;; (global-set-key (kbd "M-y") 'anything-show-kill-ring)
;; (key-chord-define-global "jk" 'anything)
