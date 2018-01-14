;;; Package --- Summary:
;;; lua mode

;;; Commentary:
;;; Code:

(require-packages '(company-lua lua-mode flymake-lua luarocks))

(defun lua-mode-seutp ()
  "Configuration for lua-mode."
  (electric-indent-mode +1))

(add-hook 'lua-mode-hook 'lua-mode-setup)
;;; lua-custom.el ends here
