;;====================================
;;perlに関して
;;====================================

(defalias 'perl-mode 'cperl-mode)

(setq cperl-electric-keywords t)
(setq cperl-hairy t)

;; perl_outline
(add-hook
 'cperl-mode-hook
 '(lambda ()
    (setq outline-regexp "\\([#\f]+\\|sub\\)")
    (setq outline-level ;this outline-level see last character
	  (function
	   (lambda ()
	     (save-excursion
	       (looking-at outline-regexp)
	       (let
		   ((ca (char-to-string (char-before (match-end 0)))))
		 (cond
		  ((equal ca "b") 1) ;"sub" to top
		  (t (- (match-end 0) (match-beginning 0)))))))))
    (outline-minor-mode t)))

;; outline
(make-variable-buffer-local 'outline-level)
(setq-default outline-level 'outline-level)
(make-variable-buffer-local 'outline-heading-end-regexp)
(setq-default outline-heading-end-regexp "\n")
(make-variable-buffer-local 'outline-regexp)
(setq-default outline-regexp "[*\f]+")
(setq outline-minor-mode-prefix "\C-c\C-o")

;; perl_mode
(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidy -q" nil t)))
(defun perltidy-defun ()
  "Run perltidy on the current defun."
  (interactive)
  (save-excursion (mark-defun)
                  (perltidy-region)))
(require 'flymake)


;; set-perl5lib
;; 開いたスクリプトのパスに応じて、@INCにlibを追加してくれる
;; 以下からダウンロードする必要あり
;; http://svn.coderepos.org/share/lang/elisp/set-perl5lib/set-perl5lib.el
(require 'set-perl5lib)

;; エラー、ウォーニング時のフェイス
(set-face-background 'flymake-errline "white")
(set-face-foreground 'flymake-errline "blue")
(set-face-background 'flymake-warnline "yellow")
(set-face-foreground 'flymake-warnline "blue")

;; エラーをミニバッファに表示
;; http://d.hatena.ne.jp/xcezx/20080314/1205475020
(defun flymake-display-err-minibuf ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
         (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count               (length line-err-info-list)))
    (while (> count 0)
      (when line-err-info-list
        (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
               (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)))
      (setq count (1- count)))))

;; Perl用設定
;; http://unknownplace.org/memo/2007/12/21#e001
(defvar flymake-perl-err-line-patterns
  '(("\\(.*\\) at \\([^ \n]+\\) line \\([0-9]+\\)[,.\n]" 2 3 nil 1)))

(defconst flymake-allowed-perl-file-name-masks
  '(("\\.pl$" flymake-perl-init)
    ("\\.pm$" flymake-perl-init)
    ("\\.t$" flymake-perl-init)))

(defun flymake-perl-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "perl" (list "-wc" local-file))))

(defun flymake-perl-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-perl-file-name-masks))
  (setq flymake-err-line-patterns flymake-perl-err-line-patterns)
  (set-perl5lib)
  (flymake-mode t))

(add-hook 'cperl-mode-hook 'flymake-perl-load)

					;cperl-modeデフォルトで使う

;; pod-mode
(require 'pod-mode)
(add-to-list 'auto-mode-alist
	     '("\\.pod$" . pod-mode))
(add-hook 'pod-mode-hook
	  '(lambda () (progn
			(font-lock-mode)
			(auto-fill-mode 1)
			(flyspell-mode 1)
			)))

;;; perlplus
;;; http://www.gentei.org/~yuuji/software/perlplus.el
(add-hook 'cperl-mode-hook
	  (lambda ()
	    (require 'perlplus)
					;(define-key perl-mode-map "\M-\t" 'perlplus-complete-symbol)
	    (define-key cperl-mode-map "\M-\t" 'perlplus-complete-symbol)
					; Debugger
	    (define-key cperl-mode-map "\C-c\C-c" 'cperl-db)
	    (perlplus-setup)))

;; perltidy
;; (defun perltidy-region ()
;;   "Run perltidy on the current region."
;;   (interactive)
;;   (save-excursion
;;     (shell-command-on-region (point) (mark) "perltidy -q" nil t)))
;; (defun perltidy-defun ()
;;   "Run perltidy on the current defun."
;;   (interactive)
;;   (save-excursion (mark-defun)
;; 		  (perltidy-region)))

;; (setq cperl-indent-level 4
;;       cperl-continued-statement-offset 4
;;       cperl-close-paren-offset -4
;;       cperl-label-offset -4
;;       cperl-comment-column 40
;;       cperl-highlight-variables-indiscriminately t
;;       cperl-indent-parens-as-block t
;;       cperl-tab-always-indent nil
;;       cperl-font-lock t)
;; (add-hook 'cperl-mode-hook
;;           '(lambda ()
;;              (progn
;;                (setq indent-tabs-mode nil)
;;                (setq tab-width nil)
	       
;; 					; perl-completion
;;                (require 'auto-complete)
;;                (require 'perl-completion)
;;                (add-to-list 'ac-sources 'ac-source-perl-completion)
;;                (perl-completion-mode t)
;; 	       )))

(add-hook 'cperl-mode-hook 'rainbow-delimiters-mode)

(add-hook 'cperl-mode-hook ;; or any major-mode-hooks
  (lambda ()
  (smart-newline-mode t)))
