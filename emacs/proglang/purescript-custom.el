;;; Package --- Summary:
;;; Purescript Mode
;;;

;;; Commentary:

;;; Code:

(require-packages '(purescript-mode psc-ide psci flycheck-purescript))

(require 'purescript-mode)
(require 'psc-ide)

;; Customization

(add-hook 'purescript-mode-hook 'psc-ide-mode)
(add-hook 'purescript-mode-hook 'inferior-psci-mode)
;;; purescript-custom.el ends here
