;;====================================
;;R ess
;;====================================
(defun ess:format-window-1 ()
  (split-window-horizontally)
  (other-window 1)
  (split-window)
  (other-window 1))
(add-hook 'ess-pre-run-hook 'ess:format-window-1)
