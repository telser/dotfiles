;;; Package --- Summary:

;;; Commentary

;;; Code:
(setq prelude-guru nil)

(custom-set-variables
 '(haskell-mode-hook '(turn-on-haskell-indentation)))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq system-uses-terminfo nil)
(provide 'personal)
;;; personal.el ends here
