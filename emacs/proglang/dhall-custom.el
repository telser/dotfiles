;; Requirements

;;; Code:

(defun dhall-setup ()
  "Settings for dhall-mode"
  (setq
   dhall-format-arguments '("--ascii"))
  )

(add-hook 'dhall-mode-hook 'dhall-setup)

;;; dhall-custom.el ends here
