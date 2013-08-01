(require 'git-gutter)

;; ;; If you enable global minor mode
(global-git-gutter-mode t)
(global-set-key [f1] 'git-gutter)

;; If you enable git-gutter-mode for some modes
(add-hook 'ruby-mode-hook 'git-gutter-mode)

(global-set-key (kbd "C-x C-g") 'git-gutter:toggle)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)

;; ;; Jump to next/previous hunk
(global-set-key (kbd "C-x p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x n") 'git-gutter:next-hunk)

;; Revert current hunk
(global-set-key (kbd "C-x r") 'git-gutter:revert-hunk)

(setq git-gutter:modified-sign "mm") ;; two space
(setq git-gutter:added-sign "++")    ;; multiple character is OK
(setq git-gutter:deleted-sign "--")

(set-face-background 'git-gutter:modified "purple") ;; background color
(set-face-foreground 'git-gutter:added "green")
(set-face-foreground 'git-gutter:deleted "red")


(setq git-gutter:update-hooks '(after-save-hook after-revert-hook))
