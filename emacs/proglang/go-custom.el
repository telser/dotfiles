;;; Package --- Summary:
;;; Golang mode

;;; Commentary:
;;; Code:

(require-packages '(go-mode go-autocomplete go-errcheck go-gopath go-guru
                            go-projectile golint gotest))

(require 'go-mode)

(defun go-mode-seutp ()
  "Configuration for go-mode."
  (electric-indent-mode +1))

(add-hook 'go-mode-hook 'go-mode-setup)
;;; go-custom.el ends here
