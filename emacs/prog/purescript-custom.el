;;; Package --- Summary:

;;; Purescript Mode
;;;

;;; Commentary:

;;; Code:

(require-packages '(purescript-mode))
                                        ;(require 'haskell-mode-autoloads)
(require 'purescript-mode)
(require 'rainbow-delimiters)

(add-hook 'purescript-mode-hook 'purescript-hook)

;; Customization

(defun purescript-hook ()
  "Custom purescript-mode hook."

  (purescript-mode 1)
  (purescript-indent-mode 1)
  (rainbow-delimeters-mode 1)
)


;;; purescript-custom.el ends here
