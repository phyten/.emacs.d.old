(require 'direx)

;; direx:direx-modeのバッファをウィンドウ左辺に幅25でポップアップ
;; :dedicatedにtを指定することで、direxウィンドウ内でのバッファの切り替えが
;; ポップアップ前のウィンドウに移譲される
(push '(direx:direx-mode :position left :width 30 :dedicated t)
      popwin:special-display-config)

(defun direx:direx-elscreen-new-window ()
  (interactive)
  (direx:find-item-other-window)
  (elscreen-split)
  )

(add-hook 'direx:direx-mode-hook
	  (lambda()
	    (define-key direx:direx-mode-map "o" 'direx:direx-elscreen-new-window)
	    )
	  )

(defun chomp (str)
  (replace-regexp-in-string "[\n\r]+$" "" str))

(defun git-project-p ()
  (string=
   (chomp
    (shell-command-to-string "git rev-parse --is-inside-work-tree"))
   "true"))

(defun git-root-directory ()
  (cond ((git-project-p)
         (chomp
          (shell-command-to-string "git rev-parse --show-toplevel")))
        (t
         "")))

(defun direx:jump-to-git-project-directory ()
  (interactive)
  (let* ((git-root-dir))
    (setq git-root-dir (git-root-directory))
    (unless (string= git-root-dir "")
      (direx:find-directory-noselect git-root-dir))
    (direx:jump-to-directory-other-window)))

