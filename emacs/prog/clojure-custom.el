;;;; Clojure mode setup

(require-packages '(clojure-mode cider typed-clojure-mode
                                 clojure-snippets clojurescript-mode))

(require 'clojure-mode)
(require 'cider)
(require 'rainbow-delimiters)

(defun clojure-mode-setup ()
  (electric-indent-mode +1)
  (subword-mode +1)
  (rainbow-delimiters-mode +1))

(defun cider-mode-setup ()
  (rainbow-delimiters-mode +1)
  (subword-mode +1)
  (whitespace-mode -1))

(add-hook 'clojure-mode-hook 'enable-paredit-mode)
(add-hook 'clojure-mode-hook 'clojure-mode-setup)
(add-hook 'cider-repl-mode-hook 'cider-mode-setup)
