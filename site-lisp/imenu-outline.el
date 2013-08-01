;; imenu-outline.el - Copyright (C) 2001 Kevin Broadey
;;
;; Author:   Kevin Broadey <kevin@broadey.co.uk>
;; Version:  1.1
;; Date:     18-Mar-2001
;;
;; Usage:
;;   Put imenu-outline.el somewhere in your load-path and byte-compile it,
;;   and add the following to your .emacs, site-start.el or default.el:
;;
;;     (eval-after-load "outline" '(require 'imenu-outline))
;;
;; Commentary:
;;   Creates an imenu structure from the outline headings in a buffer.
;;   Uses alist nesting to mimic the outline heading nesting so that L2
;;   headings appear in a submenu of parent L1 heading.  E.g. given:
;;
;;   * 1
;;   ** 1.1
;;   *** 1.1.1
;;   *** 1.1.2
;;   ** 1.2
;;   *** 1.2.1
;;   *** 1.2.2
;;   * 2
;;   ** 2.1
;;   *** 2.1.1
;;   *** 2.1.2
;;   ** 2.2
;;   *** 2.2.1
;;   *** 2.2.2
;;
;;   the imenu alist is:
;;
;;   (("1" ("1" . 1)
;;         ("1.1" ("1.1" . 5) ("1.1.1" . 12) ("1.1.2" . 22))
;;         ("1.2" ("1.2" . 32) ("1.2.1" . 39) ("1.2.2" . 49)))
;;    ("2" ("2" . 59)
;;         ("2.1" ("2.1" . 63) ("2.1.1" . 70) ("2.1.2" . 80))
;;         ("2.2" ("2.2" . 90) ("2.2.1" . 97) ("2.2.2" . 107))))
;;
;;   The algorithm works as follows:
;;
;;     Starting from the end of the buffer, search backwards for each
;;     outline heading.
;;
;;     (1) If the heading has the same outline level as the others
;;     already encountered, add an entry "(heading . position)" to the
;;     alist.
;;
;;     (2) If the heading has a higher outline level (i.e. is more deeply
;;     nested) then push the current alist onto a stack and start a new
;;     one with this "(heading . position)".
;;
;;     (3) If the heading has a lower outline level then gather all its
;;     children from the alist stack, add a "(heading . position)" entry
;;     to allow navigation to this heading, and create a submenu
;;     structure "(heading child-alists)".
;;
;;   Working from the end of the buffer back to the beginning seems
;;   simpler to me as you start off by finding lower-level headings, then
;;   wrap them up and treat the composite as a single item when a
;;   higher-level heading is found.

(defun imenu-outline-create-index ()
  (let ((alist-level -1)
	imenu-alist imenu-alist-stack)
    (goto-char (point-max))
    ;; Implement "repeat BODY until TEST" as a do-while loop using
    ;; "(while (progn BODY (not TEST)))"
    (while
	(progn
	  (outline-previous-visible-heading 1)
	  (if (outline-on-heading-p)
	      (let ((item-level (outline-level))
		    (item-name (buffer-substring-no-properties
				(save-excursion
				  (looking-at outline-regexp)
				  (goto-char (match-end 0))
				  (skip-chars-forward " \t")
				  (point))
				(save-excursion
				  (re-search-forward outline-heading-end-regexp nil 'move)
				  (goto-char (match-beginning 0))
				  (skip-chars-backward " \t")
				  (point))))
		    (item-pos (point)))
		;; If item has higher outline level than those in current
		;; alist then it is a (great ...) neice/nephew to them.
		;; Stack the current alist until we find its parent.
		(if (> item-level alist-level)
		    (setq imenu-alist-stack (cons (cons alist-level imenu-alist)
						  imenu-alist-stack)
			  imenu-alist nil))

		;; Alist is empty or item is sibling or ancestor of those
		;; already found.  Whichever it is, push the item onto the
		;; alist.
		(setq imenu-alist (cons (cons item-name item-pos) imenu-alist))

		;; If item is ancestor of previous ones, gather all
		;; (grand)children from stack and wrap them in a
		;; sub-alist.  We do not gather just direct children as
		;; there may be gaps in the outline hierarchy.
		(if (< item-level alist-level)
		    (progn
		      ;; Gather (grand)children.
		      (while (and imenu-alist-stack
				  (< item-level (caar imenu-alist-stack)))
			(nconc imenu-alist (cdar imenu-alist-stack))
			(setq imenu-alist-stack (cdr imenu-alist-stack)))
		      ;; Wrap in sub-alist.
		      (setq imenu-alist (list (cons item-name imenu-alist)))))

		;; Store outline level of item at the head of the alist.
		(setq alist-level item-level)
		))
	  ;; Here's the test for the do-while loop.
	  (not (bobp))))

    ;; Tidy up time.  The alist stack will contain siblings (and possibly
    ;; orphaned (great ...) neices/nephews) of the current alist.  Gather
    ;; them all up.
    (while imenu-alist-stack
      (nconc imenu-alist (cdar imenu-alist-stack))
      (setq imenu-alist-stack (cdr imenu-alist-stack)))

    ;; return the alist
    imenu-alist
    ))

;; Set outline-mode and outline-minor-mode startup hooks to configure
;; imenu to use imenu-outline.

(defun imenu-outline-setup ()
  (setq imenu-create-index-function 'imenu-outline-create-index))

(add-hook 'outline-mode-hook 'imenu-outline-setup)
(add-hook 'outline-minor-mode-hook 'imenu-outline-setup)

(provide 'imenu-outline)

;; End of imenu-outline.el
