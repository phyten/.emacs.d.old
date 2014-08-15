;; =======================================================================
;; 基本的なキーバインドの変更及び追加
;; =======================================================================
;; UNDO
(global-set-key "\C-z" 'undo)
;; Yank
(global-set-key "\C-y" 'yank)
;; Ctrl-Hでバックスペース
(global-set-key "\C-h" 'backward-delete-char)
;; Meta-Hで単語分バックスペース
(global-set-key "\M-h" 'backward-kill-word)
;; フレーム移動
(define-key global-map [f8] 'other-frame)
;; M-aでインデントが終わった後まで戻る
(global-set-key (kbd "M-a") 'back-to-indentation)

;; =======================================================================
;;  Misc
;; =======================================================================
;; 履歴をたくさん保存できるようにする
(setq history-length 1000)
;; emacs終了後も履歴を保存しておく
(savehist-mode 1)
;; infoの文字化け防止
(auto-compression-mode t)
;; スクロールバー非表示
(set-scroll-bar-mode nil)
(scroll-bar-mode -1)
;; 背景を透過に設定
;; (set-frame-parameter nil 'alpha 100)
;; バックアップファイルを作成しない
(setq make-backup-files nil)
;; 対応を表示する
(show-paren-mode t)
;; "yes or no"を"y or n"に
(fset 'yes-or-no-p 'y-or-n-p)
;; 起動時の画面はいらない
(setq inhibit-startup-message t)
;; toolbarを消す
(tool-bar-mode nil)                           
(tool-bar-mode -1)
;; モードラインに行番号表示
(line-number-mode t)
;; モードラインに列番号表示
(column-number-mode t)
;; スクリプトファイルならば自動的にchmod+x
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)
;; Xのクリップボードとemacsのkillringを共有
(cond (window-system
(setq x-select-enable-clipboard t)
))
;; ¥の代わりにバックスラッシュを入力する
(define-key global-map [?¥] [?\\])  
;; 全角空白、Tab、改行表示
(require 'jaspace)
(setq jaspace-alternate-jaspace-string "□")
;; (setq jaspace-alternate-eol-string "↓\n")
(setq jaspace-highlight-tabs t)
(setq jaspace-modes
      (append jaspace-modes
              '(scheme-mode php-mode yaml-mode js-mode ruby-mode text-mode fundamental-mode LaTeX-mode)))
;; local varibales list の警告を出さないようにする
(custom-set-variables
 '(safe-local-variable-values (quote ((clmemo-mode . t)))))
;; コマンドのエコーを早くする
(setq echo-keystrokes 0.1)
;; scratchの初期メッセージ消去
(setq initial-scratch-message "")
;; 自動再読み込み
(global-auto-revert-mode 1)
;;タブの代わりに半角スペースを使う
(setq-default tab-width 4 indent-tabs-mode nil)

(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

(require 'smooth-scroll)
(smooth-scroll-mode -1)

;; PATHの追加
(dolist (dir (mapcar 'expand-file-name '("/usr/local/bin")))
  (setenv "PATH" (concat dir ":" (getenv "PATH")))
  (setq exec-path (append (list dir) exec-path)))

(setq echo-keystrokes 0)
