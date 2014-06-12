(require 'epc)
(require 'auto-complete-config)
(require 'python)

(add-hook 'python-mode-hook
          '(lambda()
             (setq indent-tabs-mode nil)
             (setq indent-level 2)
             (setq python-indent 2)))

(add-hook
 'python-mode-hook
 '(lambda ()
    (defun my-indent-line ()
      "modeless indent for python indentation"
      (interactive "P")
      (let ((old-this-command this-command))
        (setq this-command t)
        (python-indent-line)
        (setq this-command old-this-command)
        ))
    (setq indent-line-function 'my-indent-line)
    ))

;;;;; PYTHONPATH上のソースコードがauto-completeの補完対象になる ;;;;;
;; (setenv "PYTHONPATH" "/usr/local/lib/python2.7/site-packages")
;; jedi
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(require 'jedi)
