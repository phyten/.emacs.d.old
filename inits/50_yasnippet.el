(require 'yasnippet)
;; (require 'yasnippet-config)
(require 'anything-c-yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"            ;; personal snippets
        ))
(yas-global-mode 1)

(defun my-yas/prompt (prompt choices &optional display-fn)
  (let* ((names (loop for choice in choices
                      collect (or (and display-fn (funcall display-fn choice))
                                  coice)))
         (selected (anything-other-buffer
                    `(((name . ,(format "%s" prompt))
                       (candidates . names)
                       (action . (("Insert snippet" . (lambda (arg) arg))))))
                    "*anything yas/prompt*")))
    (if selected
        (let ((n (position selected names :test 'equal)))
          (nth n choices))
      (signal 'quit "user quit!"))))

(global-set-key (kbd "C-c C-y") 'yas/insert-snippet)

