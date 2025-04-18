;; Requirements

;;; Code:

(add-to-list 'auto-mode-alist (cons "\\.hs\\'" 'haskell-mode))
(add-to-list 'auto-mode-alist (cons "\\.cabal\\'" 'haskell-cabal-mode))

;;;; General Requires

(require 'haskell-mode)
;(require 'haskell-process)
;(require 'haskell-simple-indent)
(require 'haskell-interactive-mode)
(require 'haskell)
(require 'haskell-font-lock)
(require 'haskell-debug)
;(require 'ghci-script-mode)
(require 'company-ghci)

;(require 'lsp-ui)
;(require 'lsp-haskell)
;(add-hook 'lsp-mode-hook 'lsp-ui-mode)
;(add-hook 'haskell-mode-hook #'lsp-haskell-enable)

(require 'flycheck)
;(flycheck-add-next-checker '(warning . haskell-hlint))

;; Functions

;; Mode settings

(add-to-list 'company-backends 'company-ghci)

(setq lsp-haskell-process-path-hie "hie-wrapper")

(setq-default
 company-ghc-show-info t
 haskell-notify-p t
 ;; haskell-stylish-on-save t
 ;; haskell-mode-stylish-haskell-path "/home/trevis/.local/bin/stylish-haskell"
 haskell-process-use-presentation-mode t
 )

;; (custom-set-variables
;;  '(company-ghc-show-info t)
;;  '(haskell-process-args-ghci '())
;;  '(haskell-tags-on-save nil)
;;  '(haskell-process-suggest-remove-import-lines t)
;;  '(haskell-process-auto-import-loaded-modules t)
;;  '(haskell-process-log t)
;;  '(haskell-process-reload-with-fbytecode nil)
;;  '(haskell-process-use-presentation-mode t)
;;  '(haskell-interactive-mode-include-file-name nil)
;;  '(haskell-interactive-mode-eval-pretty nil)
;;  '(haskell-process-do-cabal-format-string ":!cd %s && unset GHC_PACKAGE_PATH && %s")
;;  '(haskell-process-type 'stack-ghci)
;;  '(haskell-process-show-debug-tips nil)
;;  '(haskell-process-suggest-hoogle-imports nil)
;;  '(haskell-process-suggest-haskell-docs-imports t))

;;;; Hooks

(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'company-mode)
(add-hook 'haskell-mode-hook 'rainbow-delimiters-mode)
(add-hook 'haskell-mode-hook 'subword-mode)
(add-hook 'haskell-interactive-mode-hook 'company-mode)
;; ;(add-hook 'haskell-interactive-mode-hook 'structured-haskell-repl-mode)
;; (add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)
;; (add-hook 'w3m-display-hook 'w3m-haddock-display)
(add-hook 'haskell-mode-hook 'hlint-refactor-mode)

;;;; Keybindings

(provide 'haskell-custom)
;;; haskell-custom.el ends here
