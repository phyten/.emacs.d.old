;;====================================
;;ruby
;;====================================
;; ruby-mode
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\.gemspec$" . ruby-mode))
(add-to-list 'interpreter-mode-alist
             '("ruby" . ruby-mode))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
;; (autoload 'inf-ruby-keys "inf-ruby"
;;   "Set local key defs for inf-ruby in ruby-mode")
;; (add-hook 'ruby-mode-hook
;;           '(lambda () (inf-ruby-keys)))
(setq hippie-expand-try-functions-list
      (cons 'yas/hippie-try-expand  hippie-expand-try-functions-list))

(setq ruby-deep-indent-paren-style nil)
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

(add-hook 'ruby-mode-hook
  '(lambda ()
     (key-combo-mode t)
     (electric-indent-mode t)
     (electric-layout-mode t)))

;; ;; ruby-electric
;; ;; 対応するカッコやendを自動補完してくれる
;; (require 'ruby-electric)
;; (add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))

;; PATHの追加
(dolist (dir (mapcar 'expand-file-name '("/usr/local/bin")))
  (setenv "PATH" (concat dir ":" (getenv "PATH")))
  (setq exec-path (append (list dir) exec-path)))

;; Rinari
(require 'rinari)
(global-rinari-mode)


;; ruby-block
;; (condition-case err
;;     (progn
;;       (require 'ruby-block)
;;       (setq ruby-block-highlight-toggle t)
;;       (defun ruby-mode-hook-ruby-block()
;;         (ruby-block-mode t))
;;       (add-hook 'ruby-mode-hook 'ruby-mode-hook-ruby-block))
;;   (error (message "failed: %s" err)))



;; シンタックスハイライト
(setq ruby-keywords
      '("alias" "and" "begin" "break" "case" "catch" "class" "def" "do"
        "elsif" "else" "fail" "ensure" "for" "end" "if" "in" "module"
        "next" "not" "or" "raise" "redo" "rescue" "retry" "return" "then"
        "throw" "super" "unless" "undef" "until" "when" "while" "yield" "lambda"
        ;; ^QRakefile keywords^P
        "task" "file" "desc" "rule"
        ;; ^Qelispunit / el4r keywords^P
        "def_test"
        ;; ^Qel4r keywords^P
        "defun"
        ;; ^Qasserts^P
        "assert_block" "assert_equal" "assert_in_delta" "assert_instance_of"
        "assert_kind_of" "assert_match" "assert_nil" "assert_no_match"
        "assert_not_equal" "assert_not_nil" "assert_not_same" "assert_nothing_raised"
        "assert_nothing_thrown" "assert_operator" "assert_raises" "assert_respond_to"
        "assert_same" "assert_send" "assert_throws" "assert" "raise_error"
        ;; ^Qrspec^P
        "context" "specify" "it"  "should" "should_not" "its"
        ;; ^Qexpectations^P
        "expect"
        ;; other keywords 追加してください。
        "puts" "print" "pp"
        )      
      ruby-highlight-keywords
      '("describe" "Expectations")
      ruby-font-lock-keywords
      (list
       ;; functions
       '("^\\s *def\\s +\\([^( \t\n]+\\)"
         1 font-lock-function-name-face)
       (cons (concat
              "\\(^\\|[^_:.@$]\\|\\.\\.\\)\\b\\(defined\\?\\|\\("
              (regexp-opt ruby-keywords)
              "\\)\\>\\)")
             2)
       `(,(concat
              "\\(^\\|[^_:.@$]\\|\\.\\.\\)\\b\\("
              (regexp-opt ruby-highlight-keywords)
              "\\>\\)")
             2 font-lock-warning-face prepend)
       ;; assignment
       ;; (regexp-opt '("=" "+=" "-=" "*=" "/=" "%=" "**=" "&=" "|=" "^=" "<<=" ">>=" "&&=" "||="))
       `("\\(?:&&\\|\\*\\*\\|<<\\|>>\\|||\\|[%&*+/|^-]\\)?=>?" 0 font-lock-warning-face)
       ;; class name
       '("\\( \\|\n\\|(\\|::\\)[A-Z][a-z0-9A-Z_]+" 0 font-lock-variable-name-face)
       ;; symbols
       '("\\( \\|\n\\|(\\|\\[\\)\\(:[a-z0-9_]+\\)" 2 font-lock-reference-face)
       ;; symbols
       '("\\( \\|\n\\|(\\|\\[\\)\\([a-z0-9_]+:\\)" 2 font-lock-variable-name-face)       

       ;; xmpfilter
       '("# =>.*$" 0 font-lock-warning-face prepend)
       ;; '(ruby-font-lock-xmpfilter-multi-line-annotation 0 font-lock-warning-face prepend)
       `(,(regexp-opt '(">=" "<=" "<=>" "==" "===" "!=" "=~")) 0 font-lock-builtin-face t)
       ;; variables
       '("\\(\\$\\|@\\|@@\\)\\([a-zA-Z0-9]\\|_\\)+" 0 font-lock-variable-name-face)
       '("\\(^\\|[^_:.@$]\\|\\.\\.\\)\\b\\(nil\\|self\\|true\\|false\\)\\>"
         2 font-lock-variable-name-face)
       ;; embedded document
       '(ruby-font-lock-docs
         0 font-lock-comment-face t)
       '(ruby-font-lock-maybe-docs
         0 font-lock-comment-face t)
       ;; ^Q"here" document^P
       '(ruby-font-lock-here-docs
         0 sh-heredoc-face t)
       '(ruby-font-lock-maybe-here-docs
         0 sh-heredoc-face t)
       `(,ruby-here-doc-beg-re
         0 sh-heredoc-face t)
       ;; general delimited string
       '("\\(^\\|[[ \t\n<+(,=]\\)\\(%[xrqQwW]?\\([^<[{(a-zA-Z0-9 \n]\\)[^\n\\\\]*\\(\\\\.[^\n\\\\]*\\)*\\(\\3\\)\\)"
         (2 font-lock-string-face t))
       ;; symbols
       '("\\(^\\|[^:]\\)\\(:\\([-+~]@?\\|[/%&|^`]\\|\\*\\*?\\|<\\(<\\|=>?\\)?\\|>[>=]?\\|===?\\|=~\\|\\[\\]=?\\|\\(\\w\\|_\\)+\\([!?=]\\|\\b_*\\)\\|#{[^}\n\\\\]*\\(\\\\.[^}\n\\\\]*\\)*}\\)\\)"
         2 font-lock-reference-face)
       ;; constants
       '("\\(^\\|[^_]\\)\\b\\([A-Z]+\\(\\w\\|_\\)*\\)"
         2 font-lock-type-face)
       ;; ^Qexpression expansion^P
       '("#\\({[^}\n\\\\]*\\(\\\\.[^}\n\\\\]*\\)*}\\|\\(\\$\\|@\\|@@\\)\\(\\w\\|_\\)+\\)"
         0 font-lock-reference-face t)
       ;; warn lower camel case
                                        ;'("\\<[a-z]+[a-z0-9]*[A-Z][A-Za-z0-9]*\\([!?]?\\|\\>\\)"
                                        ;  0 font-lock-warning-face)
       ;; ^Qeev hyperlink^P
       '("^ *#[^(\n]+\\((.*)\\)$" 1 ee-link-underline t)
     
       ))

;; yas/expandのTABのほうが優先
(defun yas/advise-indent-function (function-symbol)
  (eval `(defadvice ,function-symbol (around yas/try-expand-first activate)
           ,(format
             "Try to expand a snippet before point, then call `%s' as usual"
             function-symbol)
           (let ((yas/fallback-behavior nil))
             (unless (and (interactive-p)
                          (yas/expand))
               ad-do-it)))))

(yas/advise-indent-function 'ruby-indent-line)

(define-obsolete-variable-alias 'last-command-char 'last-command-event)

(require 'rcodetools)
(setq rct-find-tag-if-available nil)
(defun ruby-mode-hook-rcodetools ()
  (define-key ruby-mode-map "\M-\C-i" 'rct-complete-symbol)
  (define-key ruby-mode-map "\C-c\C-k" 'ruby-toggle-buffer)
  (define-key ruby-mode-map "\C-c\C-d" 'xmp)
  (define-key ruby-mode-map "\C-c\C-f" 'rct-ri))
(add-hook 'ruby-mode-hook 'ruby-mode-hook-rcodetools)

(add-hook 'ruby-mode-hook
          (lambda ()
            (make-local-variable 'ac-ignore-case)
            (setq ac-ignore-case nil)))

(add-hook 'ruby-mode-hook 'rainbow-delimiters-mode)

(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

(defun load-auto-complete ()
  (define-key ac-menu-map "\C-n" 'ac-next)
  (define-key ac-menu-map "\C-p" 'ac-previous)

  (setq ac-auto-show-menu 0.5)
  (setq ac-menu-height 20)

  (robe-mode))

; robe
(autoload 'robe-mode "robe" "Code navigation, documentation lookup and completion for Ruby" t nil)
(autoload 'robe-ac-setup "robe-ac" "robe auto-complete" nil nil)
(add-hook 'robe-mode-hook 'robe-ac-setup)

(add-hook 'ruby-mode-hook '(lambda ()
                             (load-auto-complete)
                             ))

;; RBENV
(require 'rbenv)
(global-rbenv-mode)

(eval-after-load "ruby-mode"
  '(progn
     (require 'smartparens-ruby)
     (set-face-attribute 'sp-show-pair-match-face nil
                         :background "grey20" :foreground "green"
                         :weight 'semi-bold)))

(add-hook 'ruby-mode-hook 'show-smartparens-mode)

(add-hook 'ruby-mode-hook ;; or any major-mode-hooks
  (lambda ()
  (smart-newline-mode t)))
