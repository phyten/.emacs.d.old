(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(popwin-mode 1)

;; direx-el
;; (use popwin-el devloper ver.)
;; https://github.com/m2ym/direx-el
;; (require 'direx)
(require 'direx-project)
(defun direx:jump-to-project-directory ()
  (interactive)
  (let ((result (ignore-errors
                  (direx-project:jump-to-project-root-other-window)
                  t)))
    (unless result
      (direx:jump-to-directory-other-window))))
;; (setq direx:leaf-icon "  "
;;       direx:open-icon "↓"
;;       direx:closed-icon "→")
(push '(direx:direx-mode :position left :width 50 :dedicated t)
      popwin:special-display-config)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)
(global-set-key (kbd "C-x C-k") 'direx:jump-to-project-directory)
