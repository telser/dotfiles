;;; display -- Sumary
;;; My setup for emacs display settings.

;;; Commentary:
;;; This includes theme, modeline, toolbar, font and more settings.

;;; Code:

(set-face-attribute 'default nil :family "Hack") ;; set default font
(show-paren-mode 1) ; show matching parens
(menu-bar-mode -1) ;; no need for the menubar, give back that vertical space please
(tool-bar-mode -1) ;; no need for toolbar, give back that vertical space
(global-hl-line-mode 1) ;; highlight the current line
(global-linum-mode 1) ;; show line numbers on the left
(line-number-mode -1) ;; hide line numbers from the modeline
(column-number-mode 1) ;; show the column number in the modeline

;;;; RAINBOWS!
(diminish 'rainbow-mode)
(defun rainbow-hook ()
  "All the RAINBOWS."
  (rainbow-mode 1)
  (fic-mode 1)
  (rainbow-delimiters-mode 1)
  (rainbow-identifiers-mode 1)
  (diminish 'rainbow-mode))

(add-hook 'prog-mode-hook #'rainbow-hook) ;; There is no global mode for rainbows, so turn it on for *most* programming modes.

;;; font lock
(global-font-lock-mode 1)
(setq font-lock-maximum-decoration 1)

;; Add TODO:  etc to recognized keywords for font lock
(font-lock-add-keywords
   nil '(("\\<\\(\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):\\)"
          1 font-lock-warning-face t)))

;; don't flash the screen at me..
(setq ring-bell-function 'ignore) ;; Bell is annoying the crap out of me..

(provide 'display)
;;; display.el ends here
