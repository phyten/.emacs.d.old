;;; ess-site.el --- user customization of ESS

;; Copyright (C) 1993 David M. Smith
;; Copyright (C) 1997--2007 A.J. Rossini, Rich M. Heiberger, Martin
;;	Maechler, Kurt Hornik, Rodney Sparapani, and Stephen Eglen.

;; Original Author: David Smith <D.M.Smith@lancaster.ac.uk>
;; Created: 12 Nov 1993
;; Maintainers: ESS-core <ESS-core@stat.math.ethz.ch>

;; Keywords: start up, configuration.

;; This file is part of ESS

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.	If not, write to
;; the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:

;;; This file defines all the site-specific customizations for ESS.
;;; It should be edited on a per-site basis.  Read the comments (1.1
;;; in Section 1 to see if ess-site.el must be edited.	The final
;;; directory location of this file must be supplied in
;;; ess-lisp-directory.	 The editing of remaining sections is
;;; optional.  It should then be byte-compiled, and users who wish to
;;; use ESS should add the line:
;;;    (load "/PATH/TO/THIS/FILE/ess-site")
;;; (where /PATH/TO/THIS/FILE is the path to ess-site.elc: i.e. the
;;; value of ess-lisp-directory, below) to their .emacs file.
;;;
;;; Alternatively, if the file is already in a directory specified by
;;; the load-path variable:
;;;    (require 'ess-site)
;;; will work.
;;;
;;; with XEmacs, this is simply:
;;;	 (add-path "/path/to/ess/lisp-directory")
;;; with Emacs (and in general):
;;;	 (setq load-path (cons "/path/to/ess/lisp-directory" load-path)
;;;

;; provide here; otherwise we'll get infinite loops of (require ..):
(provide 'ess-site)

;;; Code:

;;;; 1. Load path, autoloads, and major modes
;;;; ========================================
;;;
;;; (1.1) For most users the variable ess-lisp-directory will
;;; automatically be set correctly.  If you are working with an old
;;; emacs, one in which file-truename is not defined, then you might
;;; need to change the value of ess-lisp-directory to the directory
;;; which is to contain the file ess-site.elc.	This is probably the
;;; current directory, or the value of LISPDIR if it was set in the
;;; Makefile.

(eval-and-compile

  ;; Not important in XEmacs, if unpacking from ../xemacs/site-lisp/
  ;; directory.

  ;; WARNING: with Emacs 20.2 (and 20.3 in one case),
  ;; =======  MUST USE ONE OF THE NON-DEFAULT SETTINGS BELOW

  ;; NOTE again: MOST people should NOT change anything here !!!
  ;; ====	 ====	     ================

  ;; A nice default
  (defvar ess-lisp-directory
    (directory-file-name
     (file-name-directory
      (if (and (boundp 'load-file-name) load-file-name) ;; A nice default
	  (file-truename load-file-name)
	(locate-library "ess-site") )))
    "Directory containing ess-site.el(c) and other ESS lisp files.")


  ;; NON DEFAULTS:
  ;;(defvar ess-lisp-directory
  ;;(directory-file-name "/usr/local/lib/xemacs/site-lisp/ess-/lisp"))
  ;; >> or replace "ess-" above by "ESS" which would be a symbolic link..
  ;; >> This way, your .emacs (or default.el or site-start.el)
  ;; >> won't have to change with each version of ESS

  ;; example of "local" or personal use
  ;;(defvar ess-lisp-directory
  ;;(directory-file-name "/stat2/faculty/rossini/ESS/lisp"))

;;)

  ;; emacs 19.28 and 19.29 don't have functions we need.
  (if (not (fboundp 'file-name-sans-extension))
      ;; take the definition from emacs-20.6/lisp/files.el:
      (defun file-name-sans-extension (filename)
	"Return FILENAME sans final \"extension\".
The extension, in a file name, is the part that follows the last `.'."
	(save-match-data
	  (let ((file (file-name-sans-versions
		       (file-name-nondirectory filename)))
		directory)
	    (if (string-match "\\.[^.]*\\'" file)
		(if (setq directory (file-name-directory filename))
		    (expand-file-name (substring file 0 (match-beginning 0))
				      directory)
		  (substring file 0 (match-beginning 0)))
	      filename)))))

  (add-to-list 'load-path (file-name-as-directory ess-lisp-directory))

  ;; Need these as early as here [also in ./ess-comp.el] :
  (if (not (boundp 'ess-show-load-messages))
      (defvar ess-show-load-messages nil
	"If t, show many more \"loading ..\" messages."))
  (if (not (fboundp 'ess-message))
      (defun ess-message (format-string &rest args)
	"Shortcut for \\[message] only if `ess-show-load-messages' is non-nil."
	(if ess-show-load-messages (message format-string args)))
    )); eval-*-compile

;; DEBUG: (setq ess-show-load-messages t); instead of nil above

(ess-message
 (format "[ess-site:] ess-lisp-directory = '%s'" ess-lisp-directory))

;; load code to figure out what version/strain of Emacs we are running
;; must come *AFTER* load-path is set !

;;; The following require sets the following ess-local-custom-available to
;;; true if custom is provided at this point.  If we think it will be,
;;; then we can use the following (uncommented out) to make sure that
;;; it will be.	 (AJR).
(require 'ess-emcs)
;; This will override what Emacs thinks it can detect.
;;(setq ess-local-custom-available t); if custom is available, uncomment

;; SJE Thu 13 May 2004
;; Maybe ess-etc-directory should not be defcustom, since its value
;; depends on ess-lisp-directory, and is needed by other modes that are
;; loaded before the custom code.
(defvar ess-etc-directory "/usr/share/ess/etc/"
  "*Location of the ESS etc/ directory.
The ESS etc directory stores various auxillary files that are useful
for ESS, such as icons.")

(defvar ess-etc-directory-list
  '("../etc/ess/" "../etc/" "../../etc/ess/" "./etc/")
  "*List of directories, relative to `ess-lisp-directory', to search for etc.")

(while (and (not ess-etc-directory) (listp ess-etc-directory-list) (consp ess-etc-directory-list))
  (setq ess-etc-directory
	(expand-file-name (concat ess-lisp-directory "/"
				  (car ess-etc-directory-list))))
  (if (file-directory-p ess-etc-directory)
      (setq ess-etc-directory-list nil)
    (setq ess-etc-directory nil)
    (setq ess-etc-directory-list (cdr ess-etc-directory-list))
    (when (null ess-etc-directory-list)
      (beep 0) (beep 0)
      (message (concat
		"ERROR:ess-site.el:ess-etc-directory\n"
		"Relative to ess-lisp-directory, one of the following must exist:\n"
		"../etc/ess, ../etc, ../../etc/ess or ./etc"))
      (sit-for 4))))

;;-- no longer used thanks to the (unless ...) clause below --
;; (defvar ess-info-directory nil
;;   "*Location of the ESS info/ directory.
;; The ESS info directory stores the ESS info files.")

;;(1.2) If ess.info is not found, then ess-lisp-directory/../doc/info is added
;; resurrecting Stephen's version with a bug-fix & xemacs compatibility
(unless
    ;; challenge: can this become more elegant?
    (member t
	    (mapcar 'file-exists-p
		    (mapcar
		     '(lambda(x) (concat (file-name-as-directory x) "ess.info"))
		     (if (featurep 'xemacs) Info-directory-list
		       Info-default-directory-list))))
  (add-to-list (if (featurep 'xemacs)
		   'Info-directory-list 'Info-default-directory-list)
	       (expand-file-name "../doc/info/" ess-lisp-directory)))

;;; (1.3) Files ending in .q and .S are considered to be S source files
;;; Files ending in .St are considered to be S transcript files
;;;
;;; NB: in standard Emacs, files ending in .s are assembler files.  If you
;;; want to use assembler, you can comment the appropriate line below.	Of
;;; course, different users will want different modes.	If a user wants to
;;; restore default the default modes for assembly file extensions, the
;;; following can go into ~/.emacs:
;;;
;;;  (add-hook 'ess-mode-hook 'ess-restore-asm-extns)
;;;  (add-hook 'inferior-ess-mode-hook 'ess-restore-asm-extns)

(autoload 'Rd-mode "essddr" "Major mode for editing R documentation." t)

;; This is thanks to  Ed L Cashin <ecashin@uga.edu>, 03 Mar 2004 :
(defun ess-restore-asm-extns ()
  "take away the S-Plus mode association for .s and .S files added by ESS
Putting the following in ~/.emacs restores emacs' default association
between .s or .S files and assembly mode.

  (add-hook 'ess-mode-hook 'ess-restore-asm-extns)
  (add-hook 'inferior-ess-mode-hook 'ess-restore-asm-extns)
"
  (interactive)
  (when (assoc "\\.[qsS]\\'" auto-mode-alist)
    (setq auto-mode-alist
	  (remassoc "\\.[qsS]\\'" auto-mode-alist))
    ;; put .q extention back
    ;; (add-to-list is in xemacs and GNU emacs)
    (add-to-list 'auto-mode-alist '("\\.q\\'" . S-mode))))

;; Be careful when editing the following. MISTAKES WILL RESULT IN
;; *.sty BEING TREATED AS ESS[S], rather than LaTeX-mode!

(if (assoc "\\.[rR]\\'" auto-mode-alist) nil
  (setq auto-mode-alist
	(append
	 '(("\\.sp\\'"		. S-mode) ;; re: Don MacQueen <macq@llnl.gov>
	   ("\\.[qsS]\\'"	. S-mode) ;; q,s,S [see ess-restore-asm-extns above!]
	   ("\\.ssc\\'"		. S-mode) ;; Splus (>= 4.x) script files.
	   ("\\.SSC\\'"		. S-mode) ;; ditto for windoze
	   ("\\.[rR]\\'"	. R-mode)
	   ("\\.[rR]nw\\'"	. Rnw-mode)
	   ("\\.[sS]nw\\'"	. Snw-mode); currently identical to Rnw-mode
	   ("\\.[rR]profile\\'" . R-mode)
	   ("NAMESPACE\\'"	. R-mode)
	   ("\\.omg\\'"         . omegahat-mode)
	   ("\\.hat\\'"         . omegahat-mode) ;; Duncan's pref'd...
	   ("\\.lsp\\'"		. XLS-mode)
	   ("\\.do\\'"		. STA-mode)
	   ("\\.ado\\'"		. STA-mode)
	   ("\\.[Ss][Aa][Ss]\\'"	. SAS-mode)
	   ;; Many .log/.lst files, not just SAS
	   ;;("\\.log\\'"	. SAS-log-mode)
	   ;;("\\.lst\\'"	. SAS-listing-mode)
	   ("\\.[Ss]t\\'"	. S-transcript-mode)
	   ("\\.[Ss]out"	. S-transcript-mode)
	   ("\\.[Rr]t\\'"	. R-transcript-mode)
	   ("\\.[Rr]out"	. R-transcript-mode)
	   ("\\.Rd\\'"		. Rd-mode)
           ;("\\.[Bb][Uu][Gg]\\'"         . ess-bugs-mode)
           ("\\.[Bb][Oo][Gg]\\'"         . ess-bugs-mode)
           ("\\.[Bb][Mm][Dd]\\'"         . ess-bugs-mode)
           ("\\.[Jj][Mm][Dd]\\'"         . ess-jags-mode)
          )
	 auto-mode-alist)))

;; (1.4) Customize the dialects for your setup.

;;; AS OF ESS 5.1.14, if you are using Emacs 20.x, x>3, or XEmacs
;;; 21.x, x>0, you can now use the "Customize" facility for
;;; customization.

;;;; Choices for *(), where * is from inferior-*-program....
;;; Most sites will not need to use these customized program-names.  They are
;;; provided for cases where the program is not on the standard default path.
;;; If the program doesn't get located correctly by the default use of
;;; M-x S+3 (for example), then put the path name for your system into the
;;; the variable inferior-S+3-program-name.  If for any reason you want the
;;; default use of M-x S to refer to a different program than S+3, then
;;; redefine inferior-S-program-name.

;;(setq-default inferior-S3-program-name "/disk05/s/S")
;;(setq-default inferior-S+3-program-name "Splus34")
;;(setq-default inferior-S4-program-name "/disk05/s4/S")
;;(setq-default inferior-S+4-program-name "Splus")
;;(setq-default inferior-S+5-program-name "Splus5")
;;(setq-default inferior-S+6-program-name "Splus7") ; unix systems
;;(setq-default inferior-S+6-program-name "Splus8") ; unix systems
;;(setq-default inferior-R-program-name "R")	    ; unix systems
;;(setq-default inferior-R-program-name "Rterm")    ; MS Windows, see below for path as well
;;(setq-default inferior-R-program-name "C:\\Program Files\\R\\R-2.5.0\\bin\\Rterm.exe")
;;(setq-default inferior-XLS-program-name "xlispstat")
;;(setq-default inferior-ARC-program-name "arc")
;;(setq-default inferior-VST-program-name "vista")
;;(setq-default inferior-SAS-program-name "sas")
;;(setq-default inferior-OMG-program-name "/home/rossini/src/anoncvs/Omegahat/org/omegahat/bin/omegahat")
(setq-default inferior-OMG-program-name "omegahat")

;;; ESS on the Windows NT/95/98 assumes you have installed gnuclient
;;; with your NTemacs.
;;; http://www.cs.washington.edu/homes/voelker/ntemacs/contrib/gnuserv.zip
;;; Should you choose not to use gnuclient, you will need to uncomment
;;; the notepad definitions below.
;;;
;;; Send Print from S+4 GUI Commands window print icon to emacs.
;;; StatSci's S+4 default print destination for the commands window is
;;(setq-default inferior-S+4-print-command "notepad/p")
;;;
;;; The line below is the ESS default and sends the commands window
;;; to emacs, giving the user the opportunity to
;;; (1) edit the output into a clean ess-transcript file before printing, or
;;; (2) print a region of the file.
;;(setq-default inferior-S+4-print-command "S_PRINT_COMMAND=gnuclientw.exe")

;;; The editor and pager output from S+4 and Sqpe+4 are sent by
;;; StatSci default to notepad, effectively using the definition:
;;(setq-default	 inferior-S+4-editor-pager-command
;;   "options(editor='notepad', pager='notepad')")
;;;
;;; ESS sends the output from both commands to an emacs buffer using
;;; the definition:
;;(setq-default	 inferior-S+4-editor-pager-command
;;   "options(editor='gnuclient.exe', pager='gnuclientw.exe')")

;;; These commands are for running the PC version of Sqpe of S+4 and
;;; S+6 in an emacs buffer, using the same technology as ESS uses for
;;; Unix S-Plus.  Interactive graphics with javagraph are available
;;; in this mode beginning with S-Plus 6.1.
;;; See essd-sp4.el or essd-sp6w.el

;;; -----> configuration now via custom, see ./ess-cust.el and look for
;;;        inferior-Sqpe+... e.g. inferior-Sqpe+6-program-name

;;; These ddeclient values will be buffer-local on MS-Windows 9x/NT
(setq-default inferior-ess-ddeclient	     "Initial")
(setq-default inferior-ess-client-name	     "Initial")
(setq-default inferior-ess-client-command    "Initial")

;;; S-Plus 6 for Windows startup time depends on the amount of RAM and
;;; the processor speed.  ESS needs to build a delay into the M-x S+6
;;; sequence to allow time for S-Plus 6 to open the Commands window.
;;; We then send several lines to the Commands window before returning
;;; control to the user.  On a 300 MHz machine with 96MB of RAM the
;;; delay is 60 seconds.  On a ???? MHz machine with 523MB the delay is
;;; 10 seconds.	 The user may need to adjust this number.
(defvar ess-S+6-startup-delay 15 ;; <- 2005-01-03; MM
"*Number of seconds to wait for the Commands window to appear before
sending `inferior-ess-language-start' to S-Plus.")


;;; see essd-els.el

;;(setq-default inferior-S-elsewhere-program-name "sh")
;;(setq-default inferior-S-elsewhere-program-name "ssh")
;;; You might consider using ssh, if you can!  (and if you really do
;;; this, use ssh-agent, etc, for securing your sessions).


;;;; Choice for S().
;;(setq-default inferior-S-program-name inferior-S+3-program-name)





;; (1.5) Require the needed dialects for your setup.
(if (< max-specpdl-size 700)	 ;;; ESS won't load at the default of 600
    (setq max-specpdl-size 700))

(ess-message "[ess-site:] Before requiring dialect 'essd-** ....")
(ess-message "[ess-site:] require 'essd-r ...")
(require 'essd-r)    ;; R
;; (ess-message "[ess-site:] require 'essd-s4 ...")
;; (require 'essd-s4) ; has become VERY RARE ..

;;(ess-message "[ess-site:] require 'essd-s3 ...")
;;(require 'essd-s3)  ; THIS IS RARE.  You probably do not have this.

;; "sp" refers to S-PLUS (MathSoft/StatSci/Insightful/TIBCO):
(ess-message "[ess-site:] require 'essd-sp3 ...")
(require 'essd-sp3)

(if ess-microsoft-p
    (progn
      (ess-message "[ess-site:] require 'essd-sp4 ...")
      (require 'essd-sp4)
      (ess-message "[ess-site:] require 'essd-sp6w ...")
      (require 'essd-sp6w))
  ;; else: decent OS
  (ess-message "[ess-site:] require 'essd-sp5 ...")
  (require 'essd-sp5)
  (ess-message "[ess-site:] require 'essd-sp6 ...")
  (require 'essd-sp6))

(ess-message "[ess-site:] require 'essd-sta ...")
(require 'essd-sta)  ;; for Stata.
(ess-message "[ess-site:] require 'essd-xls ...")
(require 'essd-xls)  ;; XLispStat
(ess-message "[ess-site:] require 'essd-vst ...")
(require 'essd-vst)  ;; ViSta
(ess-message "[ess-site:] require 'essd-arc ...")
(require 'essd-arc)  ;; Arc
(ess-message "[ess-site:] require 'essd-sas ...")
(require 'essd-sas)
(ess-message "[ess-site:] require 'essd-els ...")
(require 'essd-els)  ;; S-elsewhere, on another machine by telnet
(ess-message "[ess-site:] require 'essd-omg ...")
(require 'essd-omg)  ;; for omegahat
(ess-message "[ess-site:] require 'essl-bugs ...")
(require 'essl-bugs)  ;; for batch BUGS

(ess-write-to-dribble-buffer
   (format "[ess-site.el]: ess-customize-alist=%s \n"
	   ess-customize-alist))

;;; (1.7) Literate Data Analysis
(require 'ess-noweb)
(require 'ess-swv); for Sweave

;; ALWAYS:
(ess-message "[ess-site:] require 'ess   *ITSELF* ...")
(require 'ess); -> loads ess-cust.el and more

(ess-write-to-dribble-buffer
   (format "[ess-site.el _2_]: ess-customize-alist=%s \n"
	   ess-customize-alist))

;; (1.8) Speedbar and mouse

(require 'ess-menu)
(require 'ess-mous)

;; (1.9) Toolbar support

;; To remove toolbar support under ESS, either comment-out
;; (require 'ess-toolbar) below, or add "(setq ess-use-toolbar nil)"
;; to your .emacs before (require 'ess-site).
(require 'ess-toolbar)

;;; 2. Site Specific setup
;;;; ===============================================

;;; Set this to the name of the program you use to run S or S-PLUS.  It
;;; can be an absolute pathname, if you wish.
;;(setq inferior-ess-program "Splus")
;;(setq inferior-ess-program (concat (getenv "SHOME") "/Splus"))

;;; You will need to change the following two variables if you use a
;;; non-standard S prompt.
;; (setq inferior-ess-primary-prompt "[a-zA-Z0-9() ]*> ?")
;; (setq inferior-ess-secondary-prompt "+ ?")


;;; 2.1 Backwards compatibility (roll your own!)
;;; What you want S and R to call...

(autoload 'ess-transcript-mode "ess-trns"
  "Major mode for editing S transcript files." t)

(autoload 'ess-rdired "ess-rdired"
  "View *R* objects in a dired-like buffer." t)

(autoload 'ess-roxygen-fn "ess-roxygen"
  "Insert roxygen tags for function definitions." t)

;;; On a PC, the default is S+6.
;; Elsewhere (unix and linux) the default is S+6
(cond (ess-microsoft-p ; MS-Windows
       (fset 'S 'S+6)
       (fset 'Sqpe 'Sqpe+6)
       (fset 's-mode 'S+6-mode)
       (fset 's-transcript-mode 'S+6-transcript-mode))

      ((eq system-type 'gnu/linux)	; Linux -- no S+3
       (fset 'S 'S+6)
       (fset 's-mode 'S+6-mode)
       (fset 's-transcript-mode 'S+6-transcript-mode))

      (t				; Other Unixen
       (fset 'S 'S+6)
       (fset 's-mode 'S+6-mode)
       (fset 's-transcript-mode 'S+6-transcript-mode)))


;;;;* Alias S-mode to s-mode
;;; Emacs will set the mode for a file based on the file's header.
;;; The mode name is indicated by putting it between -*- on the top line.
;;; (Other commands can go here too, see an Emacs manual.)
;;; For a file you also load, you will want a leading # (comment to S)
;;; Emacs will downcase the name of the mode, e.g., S, so we must provide
;;; s-mode in lower case too.  That is, "#-*- S-*-" invokes s-mode and
;;; not S-mode.
(fset 'S-transcript-mode 's-transcript-mode)
(fset 'S-mode 's-mode)

;;; Create functions for calling different (older or newer than default)
;;;  versions of R and S(qpe).
(defvar ess-versions-created nil
  "list of strings of all S- and R-versions found on the current computer environment")

;; is currently used (updated) by ess-find-newest-R
(defvar ess-r-versions-created nil
  "list of strings of all R-versions found on the current computer environment")
;; FIXME: should then update ess-versions-created as well (easy),
;; -----  *and* update the "Start Process" menu (below)
;;    -> To this: wrap the following in functions that can be re-called

(let ( (ess-s-versions-created)
       ;;(ess-r-versions-created)
       (R-newest-list '("R-newest"))
       )
  (if ess-microsoft-p
      (progn
	(setq ess-s-versions-created
	      (ess-sqpe-versions-create))   ;; use ess-SHOME-versions
	(setq ess-rterm-version-paths (ess-find-rterm))
	)
    ;;else  real OS :
      (setq ess-s-versions-created
	    (ess-s-versions-create))      ;; use ess-s-versions
      )

  (setq ess-r-versions-created ;;  for Unix *and* Windows, using either
	(ess-r-versions-create));; ess-r-versions or ess-rterm-version-paths (above!)

  ;; Add the new defuns, if any, to the menu.
  ;; Check that each variable exists, before adding.
  ;; e.g. ess-sqpe-versions-created will not be created on Unix.
  (setq ess-versions-created
	(ess-flatten-list
	 (mapcar (lambda(x) (if (boundp x) (symbol-value x) nil))
		 '(R-newest-list
		   ess-r-versions-created
		   ess-s-versions-created))))

  (when ess-versions-created
    ;; new-menu will be a list of 3-vectors, of the form:
    ;; ["R-1.8.1" R-1.8.1 t]
    (let ((new-menu (mapcar '(lambda(x) (vector x (intern x) t))
			    ess-versions-created)))
      (easy-menu-add-item ess-mode-menu '("Start Process")
			  (cons "Other" new-menu)))))

;; Check to see that inferior-R-program-name points to a working version
;; of R; if not, try to find the newest version:
(require 'essd-r)
(ess-check-R-program-name) ;; -> (ess-find-newest-R) if needed, in ./essd-r.el

;;; 3. Customization (and commented out examples) for your site
;;;; ===============================================


;;; (3.01) SOME PEOPLE (who will remain nameless) worry that novices
;;; won't like fancy buffer names for their first (and only :-)
;;; process.  To number all processes, uncomment the next line.
;;(setq ess-plain-first-buffername nil)

;;; (3.02) Some people have requested using the program name as part
;;; of the buffer.  Turned on for R.
;;(setq ess-use-inferior-program-name-in-buffer-name t)


;;; (3.1) Font-lock
;; The following two expressions automatically enable font-lock-mode
;; for ess-mode and inferior-ess-mode buffers.

;; FIXME: XEmacs and Emacs 21.x has font-lock for ttys, as well.
;; So we need a better check! [or do this unconditionally -working everywhere ??]
(when (and window-system ess-font-lock-mode)
  (add-hook 'ess-mode-hook 'turn-on-font-lock t)
  (add-hook 'ess-transcript-mode-hook 'turn-on-font-lock t)
  (add-hook 'inferior-ess-mode-hook 'turn-on-font-lock t))

;; If nil, then don't font-lock the input
;; if t, font-lock (default).
(setq inferior-ess-font-lock-input t) ; from RMH

;;; (3.2) Framepop.  Windows produced by ess-execute-objects etc. are
;;; often unnecessarily large. The framepop package makes such
;;; windows appear in a separate, shrink-wrapped frame. This will
;;; also affect other "temporary" windows such as those produced by
;;; C-h k, etc.	 To enable, uncomment both lines of code below).
;;;
;;; Works only with Emacs at this time.
;; (cond (window-system
;;	 (require 'framepop)))

;;; (3.3) ess-keep-dump-files.
;;; Documentation:
;;; *Variable controlling whether to delete dump files after a successful load.
;;; If nil: always delete.  If `ask', confirm to delete.  If `check', confirm
;;; to delete, except for files created with ess-dump-object-into-edit-buffer.
;;; Anything else (for example `always'): always keep and never delete.
;;; This variable only affects the behavior
;;; of ess-load-file.  Dump files are never deleted if an error occurs
;;; during the load.
;;;
;;; RH sez: I find the default `always' keep to be imperative.	The previous
;;; default was to throw away
;;; files at the wrong time (I think it was something like, if you M-x
;;; ess-load a file twice, while you are working on it, the file is
;;; deleted).  I believe source is real and the ESS object is temporary.
;;; The previous default behavior is dangerous for people who believe this way.
;;; It made sense only for people who believe the object is real
;;; and the source file temporary.
(setq ess-keep-dump-files "always")

;;; (3.4) ess-ask-for-ess-directory
;;; If t, will ask for the directory to use.  If nil, assumes the
;;; default (usually, the users home directory...).
;;now rather in ./ess-cust.el : (setq ess-ask-for-ess-directory t)

;;; (3.5) ess-directory default	 (correlated with above)
;;; The default location for running the subprocess is configurable.
;;; By default, that is the default-directory (a lisp variable which
;;; initially contains the directory from which the inferior ESS
;;; statistical package/process	 is started).
;;; For example, the following function (added to the pre-run-hook, by
;;; the line following it) will set the default directory to be your
;;; home directory:
;;;
;;(defun ajr:ess-set-directory ()
;;  "Set ess-directory to home."
;;  (setq-default ess-directory (file-name-as-directory (getenv "HOME"))))
;;(add-hook 'ess-pre-run-hook 'ajr:ess-set-directory)
;;;
;;; If you replace the setq-default line with:
;;;
;; (setq-default ess-directory (file-name-as-directory
;;			    (concat (getenv "HOME") "/ess/")))
;;;
;;; then it will always start up in the directory "ess" in your home
;;; directory.
;;;
;;; The default is to have ess to start up in the current buffer's
;;; directory (the one in which you started the inferior ESS
;;; statistical package/process).  This is obtained
;;; by setting ess-directory to nil, i.e.
;; (setq-default ess-directory nil) ; this is the default.

(if ess-microsoft-p
    (add-hook 'ess-post-run-hook
	      '(lambda()
		 (if (string= ess-dialect "R")
		     (ess-eval-linewise "options(chmhelp = FALSE)"
					nil nil nil 'wait)))))


;;; 3.6 Example of formatting changes

;;; Formatting and indentation patterns are defined in ess-cust.el, please
;;; see ess-cust.el for exact definitions of these variable settings.
;;; To change them, uncomment one or both of the following lines:
;;; (eg, follow changes suggested by Terry Therneau)
;;(setq ess-fancy-comments nil)
;;(setq ess-default-style 'CLB)

;;; 4.0 SAS configuration

;;; Beginning with ESS 5.1.13, we have editing options in SAS-mode.
;;; The default behavior is as it was in prior releases.
;;;
;;; There are two sets of alternatives.
;;;   1. Editing SAS-mode files.
;;;   1a. Default: TAB is bound to sas-indent-line.
;;;	  Current line is correctly indented as SAS code.  Equivalent to
;;;(setq ess-sas-edit-keys-toggle nil) ;; default TAB in sas-mode
;;;   1b. Optional: TAB is bound to tab-to-tab-stop and inserts up to 4
;;;	  columns at a time.  C-TAB moves backwards and deletes characters
;;;	  up to 4 columns at a time.
;;;	  Uncomment the following line for the optional behavior.
;;;(setq ess-sas-edit-keys-toggle t)   ;; optional TAB and C-TAB in sas-mode
;;;   Use the function call (ess-sas-edit-keys-toggle)
;;;   to change the setting after the first SAS-mode buffer has been created.
;;;   1c. You can also define C-TAB in all modes by Option 2b (below).
;;;
;;;   2. Managing submitted SAS jobs with function keys.
;;;   2a. Default: To define the function keys in ESS[SAS] mode only,
;;;   uncomment at most one of the following two lines.
;;;(setq ess-sas-local-unix-keys t)  ;; F2-F12 bound in ESS[SAS] mode
;;;(setq ess-sas-local-pc-keys t)    ;; F2-F12 bound in ESS[SAS] mode
;;;
;;;   2b. Options: To define the function keys in all modes,
;;;   uncomment at most one of the following two lines.
;;;(setq ess-sas-global-unix-keys t) ;; F2-F12 bound in all modes
;;;(setq ess-sas-global-pc-keys t)   ;; F2-F12 bound in all modes
;;;
;;;   3. If it is more convenient to have "*Async Shell Command*"
;;;	 in same-window-buffer-names, then uncomment the following line
;;;(ess-same-window-async)
;;;
;;;(defvar sas-program "sas" "*Name of program which runs sas.")
;;;
;;;(defvar sas-indent-width 4 "*Amount to indent sas statements")

 ; Local variables section

;;; This file is automatically placed in Outline minor mode.
;;; The file is structured as follows:
;;; Chapters:	  ^L ;
;;; Sections:	 ;;*;;
;;; Subsections: ;;;*;;;
;;; Components:	 defuns, defvars, defconsts
;;;		 Random code beginning with a ;;;;* comment
;;; Local variables:
;;; mode: emacs-lisp
;;; mode: outline-minor
;;; outline-regexp: "\^L\\|\\`;\\|;;\\*\\|;;;\\*\\|(def[cvu]\\|(setq\\|;;;;\\*"
;;; End:

;;; ess-site.el ends here
