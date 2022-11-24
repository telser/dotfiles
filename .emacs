;;; emacsconfig  --- Summary

;;; Commentary:
;;; what is there to say? It's a config
;;; Code:
(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;; (setq interprogram-cut-function nil)

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
  (auto-package-update-at-time "03:00"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-haskell-plugin-import-lens-code-lens-on nil)
 '(lsp-haskell-plugin-refine-imports-global-on nil)
 '(lsp-headerline-breadcrumb-enable nil)
 '(package-selected-packages
   '(ein htmlize sqlformat magit git ialign jump-char jq-format org-ac flycheck-irony zoom-window window-number windresize window-jump darkokai-theme syntax-subword smartparens command-log-mode smex))
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
(put 'upcase-region 'disabled nil)
