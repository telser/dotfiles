;;; Package --- Summary:
;;; Rust Mode
;;;

;;; Commentary:

;;; Code:

(require-packages '(cargo flycheck-rust flymake-rust
                           racer rust-mode rust-playground))

(defun rust-mode-setup ()
  "Configuration for 'rust-mode'."
  (require 'flymake-rust)
  (add-hook 'rust-mode-hook 'flymake-rust-load)
  (setq flymake-rust-use-cargo 1)
  (with-eval-after-load 'rust-mode
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode))

;; Customization

(add-hook 'rust-mode-hook 'rust-mode-setup)

;;; rust-custom.el ends here
