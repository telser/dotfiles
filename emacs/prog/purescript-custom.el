;;; Package --- Summary:

;;; Purescript Mode
;;;

;;; Commentary:

;;; Code:

(require-packages '(purescript-mode psc-ide flycheck-purescript))

(require 'purescript-mode)
(require 'rainbow-delimiters)
(require 'psc-ide)

;; Customization

(add-hook 'purescript-mode-hook 'company-mode)
(add-hook 'purescript-mode-hook 'psc-ide-mode)
(add-hook 'purescript-mode-hook 'subword-mode)
(add-hook 'purescript-mode-hook 'rainbow-delimiters-mode)
;;; purescript-custom.el ends here
