;;; Package --- Summary:

;;; Purescript Mode
;;;

;;; Commentary:

;;; Code:

(require-packages '(purescript-mode psci psc-ide))
                                        ;(require 'haskell-mode-autoloads)
(require 'purescript-mode)
(require 'rainbow-delimiters)


;; Customization

(defun purescript-hook ()
  "Custom purescript-mode hook."

  ;; (subword-mode +1)
  (purescript-mode)
  (turn-on-purescript-indent-mode)
  ;; (rainbow-delimeters-mode +1)
)


(add-hook 'purescript-mode-hook 'purescript-hook)
;;; purescript-custom.el ends here
