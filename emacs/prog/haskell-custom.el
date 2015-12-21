;;; Package --- Summary:

;;; Haskell Mode
;;;

;;; Commentary:

;;; Code:



(defun darwin-shm () "Add shm load paths for darwin."
       (add-to-list 'load-path "~/bin/shm/elisp")
       (add-to-list 'load-path "/home/trevis/hs-prog/shm/.cabal-sandbox/share/x86_64-freebsd-ghc-7.10.2/structured-haskell-mode-1.0.20/elisp"))

(if (eq system-type 'darwin)
    (darwin-shm)
  (add-to-list 'load-path "~/bin/structured-haskell-mode"))

(setenv "PATH" (shell-command-to-string "echo $PATH"))
(setq shm-program-name "/Users/trevis/bin/structured-haskell-mode")
(require-packages '(haskell-mode ac-haskell-process ebal
                                 flycheck-haskell ghc shm))

(require 'rainbow-delimiters)
(require 'haskell)
(require 'haskell-mode)
(require 'haskell-interactive-mode)

;(require 'haskell-mode-autoloads)
;; (speedbar-add-supported-extension ".hs")
(load-file "~/emacs/prog/hs-lint.el")
(require 'hs-lint)

(eval-after-load 'flycheck
'(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))

;; Customization

(eval-after-load "which-func"
  '(add-to-list 'which-func-modes 'haskell-mode))

;; (custom-set-faces
;;  '(shm-quarantine-face ((t (:inherit font-lock-error))))
;;  '(shm-current-face ((t (:background "#efefef")))))

;; Haskell main editing mode key bindings.
(defun haskell-hook ()
  "Custom haskell-mode hook."
  ;; Use simple indentation.
  ;; (turn-on-haskell-indentation)

  ;; (haskell-indentation-mode +1)

  (subword-mode +1)

  (interactive-haskell-mode +1)

  (structured-haskell-mode +1)

  (structured-haskell-repl-mode +1)

  (turn-on-haskell-decl-scan +1)

  (rainbow-delimiters-mode +1)

;  (hs-lint-mode +1)

  (define-key haskell-mode-map (kbd "H-l") 'hs-lint))

  ;(define-key haskell-mode-map (kbd "<return>") 'haskell-simple-indent-newline-same-col)
  ;(define-key haskell-mode-map (kbd "C-<return>") 'haskell-simple-indent-newline-indent)

  ;; Load the current file (and make a session if not already made).
  ;; (define-key haskell-mode-map [f5] 'haskell-process-load-file)
  ;; (define-key haskell-mode-map (kbd "C-x C-d") nil)
  ;; (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  ;; (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
  ;; (define-key haskell-mode-map (kbd "C-c C-b") 'haskell-interactive-switch)
  ;; (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
  ;; (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
  ;; (define-key haskell-mode-map (kbd "C-c M-.") nil)
  ;; (define-key haskell-mode-map (kbd "C-c C-d") nil)

  ;; ;; Switch to the REPL.
  ;; (define-key haskell-mode-map [?\C-c ?\C-z] 'haskell-interactive-switch)
  ;; ;; “Bring” the REPL, hiding all other windows apart from the source
  ;; ;; and the REPL.
  ;; (define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)

  ;; ;; Build
  ;; (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile)
  ;; ;; Interactively choose the Cabal command to run.
  ;; (define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
  ;; (define-key haskell-mode-map (kbd "C-c v c") 'haskell-cabal-visit-file)

  ;; ;; Get the type and info of the symbol at point, print it in the
  ;; ;; message buffer.
  ;; (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
  ;; (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)

  ;; ;; Contextually do clever things on the space key, in particular:
  ;; ;;   1. Complete imports, letting you choose the module name.
  ;; ;;   2. Show the type of the symbol after the space.
  ;; (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)

  ;; ;; Jump to the imports. Keep tapping to jump between import
  ;; ;; groups. C-u f8 to jump back again.
  ;; (define-key haskell-mode-map [f8] 'haskell-navigate-imports)

  ;; ;; Jump to the definition of the current symbol.
  ;; (define-key haskell-mode-map (kbd "M-.") 'haskell-mode-tag-find)

  ;; ;; Indent the below lines on columns after the current column.
  ;; (define-key haskell-mode-map (kbd "C-," 'haskell-move-nested-left))
  ;; ;; Same as above but backwards.
  ;; (define-key haskell-mode-map (kbd "C-." 'haskell-move-nested-right)))

;; Useful to have these keybindings for .cabal files, too.
(defun haskell-cabal-hook ()
  "Cabal hook."
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)
  (define-key haskell-cabal-mode-map (kbd "C-`") 'haskell-interactive-bring)
  (define-key haskell-cabal-mode-map [?\C-c ?\C-z] 'haskell-interactive-switch))


(add-hook 'haskell-mode-hook 'haskell-hook)
(add-hook 'haskell-cabal-mode-hook 'haskell-cabal-hook)
;;; haskell-custom.el ends here
