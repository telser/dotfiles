;;; package --- Summary
;;; emacs init is there anymore to say?

;;; Commentary:
;;; Broken up into smaller files below

;; (if (not (getenv "TERM_PROGRAM"))
;;        (setenv "PATH"
;;                (shell-command-to-string "source $HOME/.zshrc && printf $PATH")))

;;; Code:

(package-initialize)

(add-to-list 'load-path "~/emacs")
(add-to-list 'load-path "~/emacs/proglang")
(load-library "base")
(load-library "elisp-custom")
(load-library "elm-custom")
(load-library "erlang-custom")
(load-library "go-custom")
(load-library "haskell-custom")
(load-library "js-custom")
(load-library "lua-custom")
(load-library "org-custom")
(load-library "purescript-custom")
(load-library "python-custom")
(load-library "ruby-custom")
(load-library "web-custom")

(server-start)
(provide '.emacs)
;;; .emacs ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (darkokai)))
 '(custom-safe-themes
   (quote
    ("6ee6f99dc6219b65f67e04149c79ea316ca4bcd769a9e904030d38908fd7ccf9" "b4fd44f653c69fb95d3f34f071b223ae705bb691fb9abaf2ffca3351e92aa374" "7ceb8967b229c1ba102378d3e2c5fef20ec96a41f615b454e0dc0bfa1d326ea6" default)))
 '(package-selected-packages
   (quote
    (company-ghci sr-speedbar smex workgroups2 persp-mode ace-window ace-jump-buffer ace-jump-mode window-jump buffer-move yasnippet undo-tree flycheck-haskell rainbow-delimiters paredit-menu paredit lusty-explorer flycheck diminish change-inner ag projectile))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
