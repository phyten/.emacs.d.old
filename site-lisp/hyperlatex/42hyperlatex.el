(setq hyperlatex-extension-dirs 
      (append '("~/.hyperlatex/" 
		"/etc/hyperlatex/" 
		"/usr/share/emacs/site-lisp/hyperlatex/") 
	      (parse-colon-path (getenv "HYPERLATEX_DIR")))) 
(autoload 'hyperlatex-format-buffer "hyperlatex/hyperlatex" 
  "Process the current buffer as hyperlatex code, into a Html document." t) 
(eval-after-load "latex"
    '(define-key LaTeX-mode-map (kbd "C-c @") 'hyperlatex-format-buffer))
