;; undohist
;; (when (require 'undohist nil t)
;;   (undohist-initialize))

;; undo-tree
(when (require 'undo-tree nil t)
  (global-undo-tree-mode)
  (define-key undo-tree-map (kbd "C-_") 'undo-tree-visualize)
  (define-key undo-tree-visualizer-mode-map (kbd "C-g") 'undo-tree-visualizer-quit)
  )
(global-set-key (kbd "M-z") 'undo-tree-redo)
(setq undo-limit 600000)
(setq undo-strong-limit 900000)

;; (when (require 'undo-tree nil t)
;;   (define-key global))
