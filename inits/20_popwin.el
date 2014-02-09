(require 'popwin)
(popwin-mode 1)
(setq display-buffer-function 'popwin:display-buffer)

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

(push '("*magit-commit*") popwin:special-display-config)
(push '("\\*magit: .+\\*" :regexp t :position right :width 0.5) popwin:special-display-config)
(push '("*magit-diff*") popwin:special-display-config)
(push '("*magit-edit-log*") popwin:special-display-config)
(push '("*magit-process*") popwin:special-display-config)
(push '(" *undo-tree*" :width 0.4 :position right) popwin:special-display-config)
