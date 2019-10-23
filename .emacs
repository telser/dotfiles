;;; package --- Summary
;;; emacs init is there anymore to say?

;;; Commentary:
;;; Broken up into smaller files below

;; (if (not (getenv "TERM_PROGRAM"))
;;        (setenv "PATH"
;;                (shell-command-to-string "source $HOME/.zshrc && printf $PATH")))


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq package-archives '(("gnu" . "[http://mirrors.163.com/elpa/gnu/](http://mirrors.163.com/elpa/gnu/)")))
(require 'cask "~/progs/cask/cask.el")
(cask-initialize "~/emacs")

;;; Code:

(add-to-list 'load-path "~/emacs")
(load-library "base")
(load-library "buffer-mgmt")
(load-library "display") ;; themes,modeline,font,etc
(add-to-list 'load-path "~/emacs/proglang")
(load-library "c-custom")
(load-library "dhall-custom")
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
(load-library "dockerfile-custom")


;(server-start)
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
    ("37ba833442e0c5155a46df21446cadbe623440ccb6bbd61382eb869a2b9e9bf9" "ab564a7ce7f2b2ad9e2cfe9fe1019b5481809dd7a0e36240c9139e230cc2bc32" "dd43ce1171324a8e47f9e4ca9f49773c4b4960706171ab951130c668adc59f53" "5f4e4c9f5de8156f964fdf8a1b8f8f659efbfeff88b38f49ce13953a84272b77" "6ee6f99dc6219b65f67e04149c79ea316ca4bcd769a9e904030d38908fd7ccf9" "b4fd44f653c69fb95d3f34f071b223ae705bb691fb9abaf2ffca3351e92aa374" "7ceb8967b229c1ba102378d3e2c5fef20ec96a41f615b454e0dc0bfa1d326ea6" default)))
 '(package-selected-packages
   (quote
    (org org-agenda-property org-alert org-beautify-theme org-caldav org-dashboard flycheck-yamllint flymake-yaml indent-tools yaml-mode company-ghci sr-speedbar smex workgroups2 persp-mode ace-window ace-jump-buffer ace-jump-mode window-jump buffer-move yasnippet undo-tree flycheck-haskell rainbow-delimiters paredit-menu paredit lusty-explorer flycheck diminish change-inner ag projectile)))
 '(safe-local-variable-values
   (quote
    ((haskell-mode-brittany-bin . "/home/trevis/work/itprotv/api-nucleus/brittany")
     (intero-stack-executable . "/home/trevis/work/itprotv/api-metrics/stack")
     (hindent-process-path . "/home/trevis/work/itprotv/api-metrics/hindent")
     (hlint . "/home/trevis/work/itprotv/api-metrics/hlint")
     (haskell-process-path-stack . "/home/trevis/work/itprotv/api-metrics/stack")
     (haskell-mode-stylish-haskell-path . "/home/trevis/work/itprotv/api-nucleus/brittany")
     (haskell-process-path-stack . "/home/trevis/work/itprotv/api-nucleus/stack")
     (hlint . "/home/trevis/work/itprotv/api-nucleus/hlint")
     (hindent-process-path . "/home/trevis/work/itprotv/api-nucleus/brittany")
     (haskell-mode . t)))))
 '(safe-local-variable-values
   (quote
    ((hlint . "/home/trevis/work/itprotv/api-nucleus/hlint")
     (intero-stack-executable . "/home/trevis/work/itprotv/api-nucleus/stack")
     (haskell-process-path-stack . "/home/trevis/work/itprotv/api-nucleus/stack")
     (intero-stack-executable concat
                              (file-name-directory
                               (buffer-file-name))
                              "stack")
     (haskell-process-path-stack concat
                                 (file-name-directory
                                  (buffer-file-name))
                                 "stack")
     (haskell-mode . t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
