;;; emacsconfig  --- Summary

;;; Commentary:
;;; what is there to say? It's a config
;;; Code:
(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; compile the child configuration files
;(byte-recompile-directory (expand-file-name "~/emacs") 0)
(add-to-list 'load-path "~/emacs")
(load-library "base")
(load-library "display")
(load-library "buffer")
(load-library "json-yaml-xml")
(load-library "org-custom")
;; some stuff specific to haskell
(load-library "haskell-custom")
;; other programming language or related stuff
(load-library "proglang")

;; Install auto-package-update to make sure everything stays up to date
(use-package auto-package-update
  :ensure t
  :demand
  :config
  (setq auto-package-update-prompt-before-update t)
  (auto-package-update-maybe))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(beacon ialign jump-char jq-format toc-org org-ac flycheck-irony zoom-window window-number windresize window-jump buffer-move darkokai-theme helm-ag syntax-subword smartparens command-log-mode smex diminish use-package))
 '(safe-local-variable-values
   '((eval setq lsp-haskell-server-path
	   (concat
	    (locate-dominating-file default-directory ".dir-locals.el")
	    ".vscode/haskell-language-server-wrapper")))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
