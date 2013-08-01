;;====================================
;; yatex
;=====================================
(setq tex-command "/home/phyten/.emacs.d/platex2pdf.sh") ;; 上記のスクリプト
; ~/.LaTeX-templateは新規ファイル作成時に自動挿入するファイル名
; (setq YaTeX-template-file "~/.LaTeX-template")
(add-hook
 'yatex-mode-hook
 '(lambda ()
    (setq outline-regexp
           "\\([ \t]*\\\\\\(documentstyle\\|documentclass\\|chapter\\|section\\|subsection\\|subsubsection\\|thebibliography\\|paragraph\\)\\*?[ \t]*[[{]\\)")
    (setq
     outline-level
     (function (lambda ()
         (save-excursion
           (looking-at outline-regexp)
           (let ((bs (buffer-substring (match-beginning 1) (match-end 1))))
             (cond ((equal (substring bs 0 4) "docu") 15)
                   ((equal (substring bs 0 4) "chap") 0)
                   ((equal (substring bs 0 4) "para") (+ 5 (length bs)))
                   (t (length bs))))))))
     (outline-minor-mode t)))
