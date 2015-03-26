;;; Package --- Summary:

;;; Commentary:

;;; Code:
(setq prelude-guru nil)

(setq ring-bell-function 'ignore)

(custom-set-variables
 '(haskell-mode-hook '(turn-on-haskell-indentation)))

(setq nrepl-hide-special-buffers t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-to-list 'custom-theme-load-path "~/emacs")

(setenv "ESHELL" (expand-file-name "~/bin/eshell"))
;;(color-theme-ir-black-chap)
(setq system-uses-terminfo nil)
(provide 'personal)
;;; personal.el ends here
