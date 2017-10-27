;;; Package --- Summary:

;;; Python Mode
;;;

;;; Commentary:

;;; Code:

(require-packages '(python-mode elpy jedi pylint pytest
                                ac-python))

(require 'rainbow-delimiters)

;; Customization

(add-hook 'python-mode-hook 'python-hook)

;; Python main editing mode key bindings.
(defun python-hook ()
  "Custom haskell-mode hook."
  ;; Use simple indentation.
  ;; (turn-on-haskell-indentation)

    (rainbow-delimiters-mode +1)
)

;;; python-custom.el ends here
