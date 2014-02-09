;;====================================
;;key-chord
;;====================================
(require 'key-chord)
(setq key-chord-two-keys-delay 0.08)
(key-chord-mode 1)
;; (key-chord-define-global "iu" 'windmove-up)
;; (key-chord-define-global "nm" 'windmove-down)
;; (key-chord-define-global "hj" 'windmove-left)
;; (key-chord-define-global "kl" 'windmove-right)
(key-chord-define-global ",." '(lambda () (interactive) (switch-to-buffer nil)))
