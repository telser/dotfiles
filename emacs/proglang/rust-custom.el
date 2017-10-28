;;; Package --- Summary:
;;; Rust

;;; Commentary:
;;; Code:

(require-packages '(rust-mode cargo flycheck-rust flymake-rust))
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;; Python main editing mode key bindings.
(defun rust-hook ()
  "Custom rust-mode hook."
  (flymake-mode-on))

(add-hook 'rust-mode-hook 'rust-hook)
;;; rust-custom ends here
