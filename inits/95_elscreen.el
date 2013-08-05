;;====================================
;; elscreen
;; =====================================
(setq elscreen-prefix-key "\C-q")
(load  "elscreen" "ElScreen" t)
(setq elscreen-display-tab 6) ; タブの幅（６以上じゃないとダメ）
(setq elscreen-tab-display-kill-screen nil) ; タブの左端の×を非表示
(global-set-key "\C-\M-h" 'elscreen-previous)
(global-set-key "\C-\M-l" 'elscreen-next)
(define-key elscreen-map "\C-c" 'elscreen-clone)
(require 'elscreen-dired)


(defun elscreen-frame-title-update ()
  (when (elscreen-screen-modified-p 'elscreen-frame-title-update)
    (let* ((screen-list (sort (elscreen-get-screen-list) '<))
	   (screen-to-name-alist (elscreen-get-screen-to-name-alist))
	   (title (mapconcat
		   (lambda (screen)
		     (format "%d%s %s"
			     screen (elscreen-status-label screen)
			     (get-alist screen screen-to-name-alist)))
		   screen-list " ")))
      (if (fboundp 'set-frame-name)
	  (set-frame-name title)
	(setq frame-title-format title)))))

(eval-after-load "elscreen"
  '(add-hook 'elscreen-screen-update-hook 'elscreen-frame-title-update))

(define-key elscreen-map "\C-c" 'elscreen-clone)
(define-key elscreen-map "c"    'elscreen-clone)
'(add-hook 'elscreen-clone-hook '(lambda () (interactive) (switch-to-buffer nil)))
