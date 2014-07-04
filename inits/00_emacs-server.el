;; (server-start)
;; (defun iconify-emacs-when-server-is-done ()
;;   (unless server-clients (iconify-frame)))
;; ;; 編集が終了したらemacsをアイコン化する
;; (add-hook 'server-done-hook 'iconify-emacs-when-server-is-done)
;; ;; C-x C-cに割り当てる（好みに応じて）
;; (global-set-key (kbd "C-x C-c") 'server-edit)
;; ;; M-x exitでemacsを終了できるようにする
;; (defalias 'exit 'save-buffers-kill-emacs)

;; run server

;; (if (eq window-system 'ns)
;;     (progn
;;       (require 'server)
;;       (unless (server-running-p)
;;         (server-start))
;;       (global-set-key (kbd "C-x C-c") 'server-edit)
;;       ))
