;;====================================
;; org-mode
;;====================================
(require 'org-install)
(setq org-startup-truncated nil)
(setq org-return-follows-link t)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-directory "~/memo/")
(setq org-default-notes-file (concat org-directory "agenda.org"))
(setq org-remember-templates
      '(("Event" ?e "** %?   \n   %i\n   %a\n   %U" nil "Events")
        ("Todo" ?t "** TODO %?\n   %i\n   %a\n   %U" nil "Inbox")
        ("Scheduling" ?s "** %?\n   %i\n   %a\n   %U" nil "Tasks")
        ("Work" ?w "** TODO %?   :work:\n   %i\n   %a\n   %U" nil "Inbox")
        ("Home" ?h "** TODO %?   :home:\n   %i\n   %a\n   %U" nil "Inbox")
        ("Idea" ?i "** %?\n   %i\n   %a\n   %U" nil "New Ideas")
        ("WorkMemo" ?m "** %?\n   %i\n   %a\n   %U" nil "Work Memos")
        ("GoodThing" ?g "** %?\n   %i\n   %U" nil "Good Things")
        ("Want" ?a "** %?\n   %i\n   %U" nil "Wants")
        ("Log" ?l "** %?\n   %i\n   %a\n   %U" nil "Inbox")
        ))
(setq org-export-html-validation-link nil)
(setq org-export-html-postamble nil)
;; (defvar org-code-reading-software-name nil)
;; ;; ~/memo/code-reading.org に記録する
;; (defvar org-code-reading-file "code-reading.org")
;; (defun org-code-reading-read-software-name ()
;;   (set (make-local-variable 'org-code-reading-software-name)
;;        (read-string "Code Reading Software: "
;;                     (or org-code-reading-software-name
;;                         (file-name-nondirectory
;;                          (buffer-file-name))))))

;; (defun org-code-reading-get-prefix (lang)
;;   (concat "[" lang "]"
;;           "[" (org-code-reading-read-software-name) "]"))
;; (defun org-remember-code-reading ()
;;   (interactive)
;;   (let* ((prefix (org-code-reading-get-prefix (substring (symbol-name major-mode) 0 -5)))
;;          (org-remember-templates
;;           `(("CodeReading" ?r "** %(identity prefix)%?\n   \n   %a\n   %t"
;;              ,org-code-reading-file "Memo"))))
;;     (org-remember)))
;; (defun org-next-visible-link ()
;;   "Move forward to the next link.
;; If the link is in hidden text, expose it."
;;   (interactive)
;;   (when (and org-link-search-failed (eq this-command last-command))
;;     (goto-char (point-min))
;;     (message "Link search wrapped back to beginning of buffer"))
;;   (setq org-link-search-failed nil)
;;   (let* ((pos (point))
;;          (ct (org-context))
;;          (a (assoc :link ct))
;;          srch)
;;     (if a (goto-char (nth 2 a)))
;;     (while (and (setq srch (re-search-forward org-any-link-re nil t))
;;                 (goto-char (match-beginning 0))
;;                 (prog1 (not (eq (org-invisible-p) 'org-link))
;;                   (goto-char (match-end 0)))))
;;     (if srch
;;         (goto-char (match-beginning 0))
;;       (goto-char pos)
;;       (setq org-link-search-failed t)
;;       (error "No further link found"))))
;; (require 'org-exp-bibtex)


;; (setq org-export-latex-coding-system 'euc-jp-unix)
;; (setq org-export-latex-date-format "%Y-%m-%d")
;; (setq org-export-latex-classes nil)
;; (add-to-list 'org-export-latex-classes
;;   '("jarticle"
;;     "\\documentclass[a4j]{jarticle}"
;;     ("\\section{%s}" . "\\section*{%s}")
;;     ("\\subsection{%s}" . "\\subsection*{%s}")
;;     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;     ("\\paragraph{%s}" . "\\paragraph*{%s}")
;;     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
;; ))

;; (defun org-previous-visible-link ()
;;   "Move backward to the previous link.
;; If the link is in hidden text, expose it."
;;   (interactive)
;;   (when (and org-link-search-failed (eq this-command last-command))
;;     (goto-char (point-max))
;;     (message "Link search wrapped back to end of buffer"))
;;   (setq org-link-search-failed nil)
;;   (let* ((pos (point))
;;          (ct (org-context))
;;          (a (assoc :link ct))
;;          srch)
;;     (if a (goto-char (nth 1 a)))
;;     (while (and (setq srch (re-search-backward org-any-link-re nil t))
;;                 (goto-char (match-beginning 0))
;;                 (not (eq (org-invisible-p) 'org-link))))
;;     (if srch
;;         (goto-char (match-beginning 0))
;;       (goto-char pos)
;;       (setq org-link-search-failed t)
;;       (error "No further link found"))))
;; (define-key org-mode-map "\M-n" 'org-next-visible-link)
;; (define-key org-mode-map "\M-p" 'org-previous-visible-link)
;; ;; latex
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; (define-key global-map "\C-cl" 'org-store-link)
;; (define-key global-map "\C-ca" 'org-agenda)
;; (define-key global-map "\C-ct" 'org-todo)
;; (setq org-log-done '(state))
;; (add-hook 'org-mode-hook
;;           '(lambda ()
;;              (flyspell-mode t)
;;              (auto-fill-mode 0)
;;              (local-set-key [(control return)] 'newline-and-indent)))

;; (setq org-export-latex-classes
;;         '(("article"
;;      "\\documentclass{jsarticle}
;; \\renewcommand{\\baselinestretch}{1.2}
;; \\usepackage{graphicx}
;; \\usepackage{longtable}
;; \\usepackage{float}
;; \\usepackage{wrapfig}
;; \\usepackage{soul}
;; \\usepackage{amssymb}
;; \\usepackage[dvipdfmx]{hyperref}"
;;      ("\\section{%s}" . "\\section*{%s}")
;;      ("\\subsection{%s}" . "\\subsection*{%s}")
;;      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;      ("\\paragraph{%s}" . "\\paragraph*{%s}")
;;      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))


;; ;; 論文
;; (add-to-list 'org-export-latex-classes
;; 	     '("thesis"
;; 	       "
;; 	       \\documentclass{jsarticle}
;; 	       \\usepackage[dvipdfmx]{graphicx}
;; 	       \\usepackage[utf8]{inputenc}
;; 	       \\usepackage[T1]{fontenc}
;; 	       "
;; 	       ("\\chapter{%s}" . "\\chapter*{%s}")
;; 	       ("\\section{%s}" . "\\section*{%s}")
;; 	       ("\\subsection{%s}" . "\\subsection*{%s}")
;; 	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;; 	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
;; 	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


;; (setq org-latex-to-pdf-process
;;       '("mypdflatex %b" "mypdflatex %b"))
;; (setq org-export-with-sub-superscripts nil)

