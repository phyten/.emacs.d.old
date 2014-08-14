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

;; Rinari
(require 'rinari)
(add-hook 'ruby-mode-hook 'rinari-minor-mode)
(add-hook 'web-mode-hook 'rinari-minor-mode)
(add-hook 'js2-mode-hook 'rinari-minor-mode)
(add-hook 'dired-mode-hook 'rinari-minor-mode)
(add-hook 'scss-mode-hook 'rinari-minor-mode)

(add-hook 'rinari-minor-mode-hook (lambda ()
                                    (define-prefix-command 'pd-rinari-map1)
                                    (define-prefix-command 'pd-rinari-map2)
                                    (local-set-key (kbd "M-R") 'pd-rinari-map1)
                                    (local-set-key (kbd "M-r") 'pd-rinari-map2)

                                    (define-key pd-rinari-map1 "'" 'rinari-find-by-context)
                                    (define-key pd-rinari-map1 ";" 'rinari-find-by-context)
                                    (define-key pd-rinari-map1 "c" 'rinari-console)
                                    (define-key pd-rinari-map1 "d" 'rinari-cap)
                                    (define-key pd-rinari-map1 "e" 'rinari-insert-erb-skeleton)
                                    (define-key pd-rinari-map1 "g" 'rinari-rgrep)
                                    (define-key pd-rinari-map1 "p" 'rinari-goto-partial)
                                    (define-key pd-rinari-map1 "q" 'rinari-sql)
                                    (define-key pd-rinari-map1 "r" 'rinari-rake)
                                    (define-key pd-rinari-map1 "s" 'rinari-script)
                                    (define-key pd-rinari-map1 "t" 'rinari-test)
                                    (define-key pd-rinari-map1 "w" 'rinari-web-server)
                                    (define-key pd-rinari-map1 "x" 'rinari-extract-partial)

                                    (define-key pd-rinari-map2 ";" 'rinari-find-by-context)
                                    (define-key pd-rinari-map2 "C" 'rinari-find-cells)
                                    (define-key pd-rinari-map2 "F" 'rinari-find-features)
                                    (define-key pd-rinari-map2 "M" 'rinari-find-mailer)
                                    (define-key pd-rinari-map2 "S" 'rinari-find-steps)
                                    (define-key pd-rinari-map2 "Y" 'rinari-find-sass)
                                    (define-key pd-rinari-map2 "a" 'rinari-find-application)
                                    (define-key pd-rinari-map2 "c" 'rinari-find-controller)
                                    (define-key pd-rinari-map2 "e" 'rinari-find-environment)
                                    (define-key pd-rinari-map2 "f" 'rinari-find-file-in-project)
                                    (define-key pd-rinari-map2 "h" 'rinari-find-helper)
                                    (define-key pd-rinari-map2 "i" 'rinari-find-migration)
                                    (define-key pd-rinari-map2 "j" 'rinari-find-javascript)
                                    (define-key pd-rinari-map2 "l" 'rinari-find-lib)
                                    (define-key pd-rinari-map2 "m" 'rinari-find-model)
                                    (define-key pd-rinari-map2 "n" 'rinari-find-configuration)
                                    (define-key pd-rinari-map2 "o" 'rinari-find-log)
                                    (define-key pd-rinari-map2 "p" 'rinari-find-public)
                                    (define-key pd-rinari-map2 "r" 'rinari-find-rspec)
                                    (define-key pd-rinari-map2 "s" 'rinari-find-script)
                                    (define-key pd-rinari-map2 "t" 'rinari-find-test)
                                    (define-key pd-rinari-map2 "u" 'rinari-find-plugin)
                                    (define-key pd-rinari-map2 "v" 'rinari-find-view)
                                    (define-key pd-rinari-map2 "w" 'rinari-find-worker)
                                    (define-key pd-rinari-map2 "x" 'rinari-find-fixture)
                                    (define-key pd-rinari-map2 "y" 'rinari-find-stylesheet)
                                    (define-key pd-rinari-map2 "z" 'rinari-find-rspec-fixture)
                                    ))
;; (global-rinari-mode)


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
       ;; ;; embedded document
       ;; '(ruby-font-lock-docs
       ;;   0 font-lock-comment-face t)
       ;; '(ruby-font-lock-maybe-docs
       ;;   0 font-lock-comment-face t)
       ;; ;; ^Q"here" document^P
       ;; '(ruby-font-lock-here-docs
       ;;   0 sh-heredoc-face t)
       ;; '(ruby-font-lock-maybe-here-docs
       ;;   0 sh-heredoc-face t)
       ;; `(,ruby-here-doc-beg-re
       ;;   0 sh-heredoc-face t)
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

(define-key ruby-mode-map (kbd "C-M-h") nil)
