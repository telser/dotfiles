;;; Package --- Summary:
;;; Js mode

;;; Commentary:
;;; Code:

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)

(js2r-add-keybindings-with-prefix "C-c C-j")
;;; js-custom.el ends here
