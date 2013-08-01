;;====================================
;; zencoding-mode
;;====================================
(require 'zencoding-mode)
(add-hook 'html-helper-mode-hook 'zencoding-mode)
(add-hook 'web-mode-hook 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode)
(define-key zencoding-mode-keymap "\C-c\C-j" 'zencoding-expand-line)
