;; ======================================================================
;; Loadpath関連
;; ======================================================================
;; サブディレクトリをすべて読み出す。
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/site-lisp/org-mode/contrib/lisp")
(let ((dir (expand-file-name "~/.emacs.d/site-lisp")))
  (if (member dir load-path) nil
    (setq load-path (cons dir load-path))
    (let ((default-directory dir))
      (load (expand-file-name "subdirs.el") t t t))))
(let ((dir (expand-file-name "~/.emacs.d/auto-install")))
  (if (member dir load-path) nil
    (setq load-path (cons dir load-path))
    (let ((default-directory dir))
      (load (expand-file-name "subdirs.el") t t t))))

					;elispと設定ファイルのディレクトリをload-pathに追加
					;(setq load-path (cons "~/.lisp" load-path))
(setq load-path
      (cons
       (expand-file-name "~/.lisp")
       (cons
        (expand-file-name "~/.emacs.d/auto-install/")
        (cons
         (expand-file-name "~/.emacs.d/site-lisp/")
         (cons
          (expand-file-name "~/.emacs.d/conf/") load-path)))))
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)             ; 互換性確保

(require 'package)

					; Add package-archives
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")) ; ついでにmarmaladeも追加
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))

					; Initialize
(package-initialize)

					; melpa.el
(require 'melpa)


(require 'init-loader)
(init-loader-load "~/.emacs.d/inits") ; 設定ファイルがあるディレクトリを指定
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(ansi-term-color-vector [unspecific "#586e75" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#002b36"])
 '(custom-enabled-themes (quote (apribase)))
 '(custom-safe-themes (quote ("d0654aebee372ea638775f4f9f64b3e80ea0462dfd4388637b798142ba5020d0" "9be47486fd092ecefbc2bff25de4025cb4543d248764b4a42892415e759ec72f" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "6cfe5b2f818c7b52723f3e121d1157cf9d95ed8923dbc1b47f392da80ef7495d" "e9a1226ffed627ec58294d77c62aa9561ec5f42309a1f7a2423c6227e34e3581" "211bb9b24001d066a646809727efb9c9a2665c270c753aa125bace5e899cb523" default)))
 '(fci-rule-color "#073642")
 '(foreign-regexp/regexp-type (quote perl))
 '(help-at-pt-display-when-idle (quote (flymake-overlay)) nil (help-at-pt))
 '(help-at-pt-timer-delay 0.3)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-tail-colors (quote (("#073642" . 0) ("#546E00" . 20) ("#00736F" . 30) ("#00629D" . 50) ("#7B6000" . 60) ("#8B2C02" . 70) ("#93115C" . 85) ("#073642" . 100))))
 '(reb-re-syntax (quote foreign-regexp))
 '(safe-local-variable-values (quote ((clmemo-mode . t))))
 '(yas-prompt-functions (quote (my-yas/prompt))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(ansi-term-color-vector [unspecific "#586e75" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#002b36"])
 '(custom-enabled-themes (quote (apribase)))
 '(custom-safe-themes (quote ("d0654aebee372ea638775f4f9f64b3e80ea0462dfd4388637b798142ba5020d0" "9be47486fd092ecefbc2bff25de4025cb4543d248764b4a42892415e759ec72f" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "6cfe5b2f818c7b52723f3e121d1157cf9d95ed8923dbc1b47f392da80ef7495d" "e9a1226ffed627ec58294d77c62aa9561ec5f42309a1f7a2423c6227e34e3581" "211bb9b24001d066a646809727efb9c9a2665c270c753aa125bace5e899cb523" default)))
 '(display-time-mode t)
 '(fci-rule-color "#073642")
 '(foreign-regexp/regexp-type (quote perl))
 '(help-at-pt-display-when-idle (quote (flymake-overlay)) nil (help-at-pt))
 '(help-at-pt-timer-delay 0.3)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-tail-colors (quote (("#073642" . 0) ("#546E00" . 20) ("#00736F" . 30) ("#00629D" . 50) ("#7B6000" . 60) ("#8B2C02" . 70) ("#93115C" . 85) ("#073642" . 100))))
 '(reb-re-syntax (quote foreign-regexp))
 '(safe-local-variable-values (quote ((clmemo-mode . t))))
 '(tool-bar-mode nil)
 '(transient-mark-mode t)
 '(yas-prompt-functions (quote (my-yas/prompt))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
