;;====================================
;; view-mode (vi-like key-map)
;;====================================
(setq view-read-only t)
(defvar pager-keybind
      `( ;; vi-like
        ("K" . windmove-up)
        ("J" . windmove-down)
        ("L" . windmove-right)
        ("H" . windmove-left)
        ("h" . backward-char)
        ("l" . forward-char)
        ("j" . next-line)
        ("k" . previous-line)
        ("n" . ,(lambda () (interactive) (scroll-up 1)))
        ("p" . ,(lambda () (interactive) (scroll-down 1)))
        ("w" . forward-word)
        ("e" . backward-word)
        ("b" . scroll-down)
        ("i" . view-mode)
        ("a" . ,(lambda () (interactive) (view-mode) (forward-char)))
        ("A" . ,(lambda () (interactive) (view-mode) (end-of-line)))
        ("o" . ,(lambda () (interactive) (view-mode) (end-of-line) (newline)))
        ("O" . ,(lambda () (interactive) (view-mode) (beginning-of-line) (newline) (previous-line)))
        (" " . scroll-up)
        ("]" . forward-sexp)
        ("[" . backward-sexp)
        ("v" . scroll-other-window)
        ("c" . scroll-other-window-down)
        ))

(defun define-many-keys (keymap key-table &optional includes)
  (let (key cmd)
    (dolist (key-cmd key-table)
      (setq key (car key-cmd)
              cmd (cdr key-cmd))
      (if (or (not includes) (member key includes))
        (define-key keymap key cmd))))
  keymap)

(defun view-mode-hook0 ()
  (define-many-keys view-mode-map pager-keybind)
;;  (hl-line-mode 1)  ;;カーソル行をハイライトしたければコメントをはずす
  (define-key view-mode-map " " 'scroll-up))
  (add-hook 'view-mode-hook 'view-mode-hook0)

;; 書き込み不能なファイルはview-modeで開くように
(defadvice find-file
  (around find-file-switch-to-view-file (file &optional wild) activate)
  (if (and (not (file-writable-p file))
           (not (file-directory-p file)))
      (view-file file)
    ad-do-it))

;; 書き込み不能な場合はview-modeを抜けないように
(defvar view-mode-force-exit nil)
(defmacro do-not-exit-view-mode-unless-writable-advice (f)
  `(defadvice ,f (around do-not-exit-view-mode-unless-writable activate)
     (if (and (buffer-file-name)
              (not view-mode-force-exit)
              (not (file-writable-p (buffer-file-name))))
         (message "File is unwritable, so stay in view-mode.")
       ad-do-it)))

(do-not-exit-view-mode-unless-writable-advice view-mode-exit)
(do-not-exit-view-mode-unless-writable-advice view-mode-disable)

;; jkの同時押しで view-mode のtoggle
;; (global-set-key [f1] 'view-mode)
;; (key-chord-define-global "gh" 'view-mode)