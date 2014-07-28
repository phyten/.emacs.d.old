;;====================================
;; 専用のキーバインド、他のモードよりも優先順位が高い
;;====================================
(setq my-keyjack-mode-map (make-sparse-keymap))
(mapcar (lambda (x)
          (define-key my-keyjack-mode-map (car x) (cdr x))
          (global-set-key (car x) (cdr x)))
        '(("\C-\M-h" . elscreen-previous) ;elscreen用の設定
          ("\C-\M-l" . elscreen-next) ;elscreen用の設定
          ([(C x) (up)] . windmove-up)
          ("\C-h" . backward-delete-char)
          ("\M-h" . backward-kill-word)
          ("\C-z" . undo)
          ("\M-2" . set-mark-command)
          ("\M-t" . other-window-or-split)
          ("\C-t" . other-window-or-split)
          ("\C-\M-i" . helm-git-files)
          ([(C x) (C n)] . cua-set-rectangle-mark)
          ([(s-return)] . cua-set-rectangle-mark)
          ([(C x) (down)] . windmove-down)
          ([(C x) (C x)] . set-mark-command)
          ([(C x) (right)] . windmove-right)
          ([(C x) (left)] . windmove-left)
          ([(C x) (C up)] . windmove-up)
          ([(C x) (C down)] . windmove-down)
          ([(C x) (C right)] . windmove-right)
          ([(C x) (C left)] . windmove-left)
          ([(C x) (p)] . windmove-up)
          ([(C x) (n)] . windmove-down)
          ([(C x) (f)] . windmove-right)
          ([(C x) (b)] . windmove-left)
          ([(C x) (C z)] . keyboard-quit)
          ([(C x) (p)] . git-gutter:previous-hunk)
          ([(C x) (n)] . git-gutter:next-hunk)
          ("\M-i" . auto-complete)
          ))

(easy-mmode-define-minor-mode my-keyjack-mode "Grab keys"
                              t " Keyjack" my-keyjack-mode-map)
