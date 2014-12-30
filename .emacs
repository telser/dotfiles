;;; package --- Summary
;;; emacs init is there anymore to say?

;;; Commentary:
;;; Broken up into smaller files below

;;; Code:
(add-to-list 'load-path "~/emacs")
(add-to-list 'load-path "~/emacs/prog")
(load-library "org-custom")
(load-library "base-custom")
(load-library "clojure-custom")
(load-library "elisp-custom")
(load-library "erlang-custom")
(load-library "haskell-custom")
(load-library "js-custom")
(load-library "ruby-custom")
(load-library "rust-custom")
(load-library "web-custom")
(load-library "ercrc")


(server-start)
(provide '.emacs)
;;; .emacs ends here
