;;====================================
;;iBuffer
;;====================================
(require 'ibuffer)
(setq ibuffer-never-show-regexps '("GNU" "messages"))
(global-set-key "\C-x\C-b" 'ibuffer)
(add-hook 'dired-load-hook
          '(lambda ()
             (load-library "ls-lisp")
             (setq ls-lisp-dirs-first t)
             (setq dired-listing-switches "-AFl")
             (setq find-ls-option '("-exec ls -AFGl {} \\;" . "-AFGl"))
             (setq grep-find-command "find . -type f -print0 | xargs -0 -e grep -ns ")
             (require 'wdired)
             ))
;バッファを表示SPC 別画面で表示したりいろいろできる
;; (defun ibuffer-visit-buffer-other-window-scroll (&optional down)
;;   (interactive)
;;   (let ((buf (ibuffer-current-buffer)))
;;     (when (and buf (buffer-live-p buf))
;;       (if (string=
;;            (buffer-name (window-buffer (next-window)))
;;            (buffer-name buf))
;;           (if down
;;               (scroll-other-window-down nil)
;;             (scroll-other-window))
;;         (ibuffer-visit-buffer-other-window-noselect))
;;       (if (eq major-mode 'ibuffer-mode)
;;           ()
;;         (setq buf (current-buffer))
;;         (switch-to-buffer (get-buffer "*Ibuffer*"))
;;         ))))

;; (defun ibuffer-visit-buffer-other-window-scroll-down ()
;;   (interactive)
;;   (ibuffer-visit-buffer-other-window-scroll t))

;; (define-key ibuffer-mode-map " " 'ibuffer-visit-buffer-other-window-scroll)
;; (define-key ibuffer-mode-map "b" 'ibuffer-visit-buffer-other-window-scroll-down)

;; ;; n, p で次 (前) のバッファの内容を表示する
;; (defadvice ibuffer-forward-line
;;   (after ibuffer-scroll-page activate)
;;   (ibuffer-visit-buffer-other-window-scroll))
;; (defadvice ibuffer-backward-line
;;   (after ibuffer-scroll-page-down activate)
;;   (ibuffer-visit-buffer-other-window-scroll-down))
;絞り込み検索 Gg
(defun Buffer-menu-grep (str)
  (interactive "sregexp:")
  (goto-char (point-min))
  (let (lines)
    (forward-line 2)
    (setq lines (buffer-substring (point-min) (point)))
    (while (re-search-forward str nil t)
      (let ((bol (progn (beginning-of-line) (point)))
            (eol (progn (forward-line) (point))))
        (setq lines (concat lines (buffer-substring bol eol)))))
    (let ((buffer-read-only nil))
      (erase-buffer)
      (insert lines))))
(define-key ibuffer-mode-map "G" 'Buffer-menu-grep)
;;sort
(defun my-sort-buffer-by (cbuf slst)
;; bury-buffer を使って、カレントバッファが先頭に来るようにソートする
  (cond ((eq slst '()) '())
        ((eq cbuf (car slst)) (my-sort-buffer-by cbuf (reverse (cdr slst))))
        (t (bury-buffer (car slst))
           (my-sort-buffer-by cbuf (cdr slst)))))

(defun my-sort-buffer-by-name (x y)
  (if (or (buffer-file-name y) (buffer-file-name x))
      ;; どちらか特殊バッファならば buffer-name でソートする
      (string< (buffer-file-name y) (buffer-file-name x))
    (string< (buffer-name y) (buffer-name x))))

(defun my-sort-buffer ()
  "Sort buffer list by name"
  (interactive)
  (let* ((cbuf (current-buffer))
         (blst (copy-sequence (buffer-list)))
         (slst (sort blst 'my-sort-buffer-by-name)))
    (my-sort-buffer-by cbuf slst)))
;; 使っているもので表示されるバッファを変える
(defun Buffer-menu-grep-match (str)
  (interactive "P")
  (call-interactively 'ibuffer)
  (save-excursion
    (goto-char (point-min))
    (let (lines)
      (forward-line 2)
      (setq lines (buffer-substring (point-min) (point)))
      (while (re-search-forward str nil t)
        (let ((bol (progn (beginning-of-line) (point)))
              (eol (progn (forward-line) (point))))
          (setq lines (concat lines (buffer-substring bol eol)))))
      (let ((buffer-read-only nil))
        (erase-buffer)
        (insert lines)))))

(defun Buffer-menu-grep-reject (str)
  (interactive "P")
  (call-interactively 'ibuffer)
  (save-excursion
    (goto-char (point-min))
    (let (lines)
      (forward-line 2)
      (setq lines (buffer-substring (point-min) (point)))
      (forward-line 1)
      (while (re-search-forward ".+$" (line-end-position) t)
        (let ((bol (progn (beginning-of-line) (point)))
              (eol (progn (forward-line) (point))))
          (if (not (string-match str (buffer-substring bol eol)))
              (setq lines (concat lines (buffer-substring bol eol))))))
      (let ((buffer-read-only nil))
        (erase-buffer)
        (insert lines)))))

(defun Buffer-menu-grep-texi ()
  (Buffer-menu-grep-match "\\(dired\\|texi\\)"))

(defun Buffer-menu-grep-rb ()
  (Buffer-menu-grep-match "\\(dired\\|\\.rb\\)"))

(defun Buffer-menu-grep-el ()
  (Buffer-menu-grep-match "\\(dired\\|scratch\\|\\.el\\)"))

(defun Buffer-menu-grep-2ch ()
  (Buffer-menu-grep-match "navi2ch"))

(defun Buffer-menu-grep-default ()
  (Buffer-menu-grep-match "\\(dired\\|texi\\)"))

(defvar my-buffer-menu-list '(
                              ("\.texi" . Buffer-menu-grep-texi)
                              ("navi2ch" . Buffer-menu-grep-2ch)
                              ("\.el" . Buffer-menu-grep-el)
                              ("\.rb" . Buffer-menu-grep-rb)
                              ("." . Buffer-menu-grep-default)
                              ))

(defun my-buffer-menu (arg)
  (interactive "P")
  (if arg
      ;;(call-interactively 'buffer-menu)
        (call-interactively 'ibuffer)
    (let ((alist my-buffer-menu-list)
          (case-fold-search t)
          (buffer-menu-com nil)
          (name (buffer-name (current-buffer))))
      (while (and (not buffer-menu-com) alist)
        (if (string-match (car (car alist)) name)
            (setq buffer-menu-com (cdr (car alist))))
        (setq alist (cdr alist)))
      (if buffer-menu-com
          (funcall buffer-menu-com)
        (call-interactively 'ibuffer)))))

(key-chord-define-global "fd" 'my-buffer-menu)       ;;キーボードのfとdを同時に押すことで実行
