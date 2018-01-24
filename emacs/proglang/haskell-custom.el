;; Requirements

;;; Code:

(require-packages '(ac-haskell-process flycheck-haskell flycheck-stack company-ghci hasky-stack hindent
                                     hamlet-mode intero stack-mode))

(add-to-list 'auto-mode-alist (cons "\\.hs\\'" 'haskell-mode))
(add-to-list 'auto-mode-alist (cons "\\.cabal\\'" 'haskell-cabal-mode))

;;;; General Requires

(require 'hindent)
(require 'haskell-mode)
(require 'haskell-process)
;(require 'haskell-simple-indent)
(require 'haskell-interactive-mode)
(require 'haskell)
(require 'haskell-font-lock)
(require 'haskell-debug)
(require 'sgml-mode)
(require 'css-mode)
(require 'ghci-script-mode)
(require 'hamlet-mode)
(require 'company-ghci)

(intero-global-mode 1)

;; Functions

;; Mode settings

(setq-default
 company-ghc-show-info t
 haskell-stylish-on-save t
 )
;; (custom-set-variables
;;  '(company-ghc-show-info t)
;;  '(haskell-process-args-ghci '())
;;  '(haskell-notify-p t)
;;  '(haskell-stylish-on-save t)
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

(add-hook 'haskell-mode-hook 'company-mode)
(add-hook 'haskell-mode-hook 'rainbow-delimiters-mode)
(add-hook 'haskell-mode-hook 'subword-mode)

;;;; Keybindings

(provide 'haskell-custom)
;;; haskell-custom.el ends here
