;;; package --- Summary
;;; emacs init is there anymore to say?

;;; Commentary:
;;; Based on an init.el file from a coworker (not in public source control)

;;; Code:
(add-to-list 'load-path "~/emacs")
(add-to-list 'load-path "~/emacs/prog")
(load-library "org-custom")
(load-library "base-custom")
(load-library "ercrc")
(load-library "clojure-custom")
(load-library "elisp-custom")
(load-library "erlang-custom")
(load-library "haskell-custom")
(load-library "js-custom")
(load-library "ruby-custom")
(load-library "rust-custom")
(load-library "web-custom")


(provide '.emacs)
;;; .emacs ends here
