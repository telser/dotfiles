;;; Package --- Summary:
;;; Purescript Mode
;;;

;;; Commentary:

;;; Code:

(require 'purescript-mode)
(require 'psc-ide)

;; Customization

(add-hook 'purescript-mode-hook 'psc-ide-mode)
(add-hook 'purescript-mode-hook 'inferior-psci-mode)
;;; purescript-custom.el ends here
