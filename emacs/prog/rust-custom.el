;;; Rust

(require-packages '(rust-mode flymake-rust))
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
