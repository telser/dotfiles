;;; Package --- Summary:
;;;; Clojure mode

;;; Commentary:

;;; Code:

(require-packages '(clojure-mode cider typed-clojure-mode
                                 clojure-snippets ac-cider clj-refactor
                                 clojure-mode-extra-font-locking))

(require 'clojure-mode)
(require 'cider)

(defun clojure-mode-setup ()
  "Clojure."
  (electric-indent-mode +1)
  (enable-paredit-mode)
  (typed-clojure-mode 1))

(defun cider-mode-setup ()
  "Cider mode stuff."
  (whitespace-mode -1))

(add-hook 'clojure-mode-hook 'clojure-mode-setup)
(add-hook 'cider-repl-mode-hook 'cider-mode-setup)
;;; clojure-custom.el ends here
