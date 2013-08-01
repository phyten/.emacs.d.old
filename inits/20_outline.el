;;====================================
;; outline-mode
;;====================================
(require 'imenu-outline)
(make-variable-buffer-local 'outline-level)
(setq-default outline-level 'outline-level)
(make-variable-buffer-local 'outline-heading-end-regexp)
(setq-default outline-heading-end-regexp "\n")
(make-variable-buffer-local 'outline-regexp)
(setq-default outline-regexp "[*\f]+")
