;;; Package --- Summary:
;;; lua mode

;;; Commentary:
;;; Code:

(defun lua-mode-seutp ()
  "Configuration for lua-mode."
  (electric-indent-mode +1))

(add-hook 'lua-mode-hook 'lua-mode-setup)
;;; lua-custom.el ends here
