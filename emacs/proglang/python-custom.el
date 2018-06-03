;;; Package --- Summary:

;;; Python Mode
;;;

;;; Commentary:

;;; Code:

;; Python main editing mode key bindings.
(defun python-hook ()
  "Custom python-mode hook."
  (anaconda-mode 1)
  (jedi-mode 1))

(add-hook 'python-mode-hook 'python-hook)
;;; python-custom.el ends here
