;; C言語
(setq c-mode-common-hook
      '(lambda ()
         (let ()
           (c-set-offset 'statement-cont 'c-lineup-math)
           )))
