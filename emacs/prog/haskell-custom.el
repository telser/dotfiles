;;; Haskell Mode
;;;

;;; TODO: Make this work cross platform!
(add-to-list 'load-path "~/Library/Haskell/ghc-7.6.3/lib/structured-haskell-mode-1.0.3/share/elisp")
(add-to-list 'load-path "/home/trevis/.cabal/share/x86_64-freebsd-ghc-7.8.3/structured-haskell-mode-1.0.4/elisp")
;; (setenv "PATH" (shell-command-to-string "echo $PATH"))
(setq shm-program-name "/home/trevis/.cabal/bin/structured-haskell-mode")
(require 'shm)
(require-packages '(haskell-mode flymake-hlint ac-haskell-process))

;(require 'haskell-mode-autoloads)
;; (speedbar-add-supported-extension ".hs")


;; Customization

(add-hook 'haskell-mode-hook 'haskell-hook)
(add-hook 'haskell-cabal-mode-hook 'haskell-cabal-hook)

(eval-after-load "which-func"
  '(add-to-list 'which-func-modes 'haskell-mode))

;; Haskell main editing mode key bindings.
(defun haskell-hook ()
  ;; Use simple indentation.
  ;; (turn-on-haskell-indentation)

  (structured-haskell-mode)
  (turn-on-haskell-decl-scan)

  ;(define-key haskell-mode-map (kbd "<return>") 'haskell-simple-indent-newline-same-col)
  ;(define-key haskell-mode-map (kbd "C-<return>") 'haskell-simple-indent-newline-indent)

  ;; Load the current file (and make a session if not already made).
  (define-key haskell-mode-map [f5] 'haskell-process-load-file)
  (define-key haskell-mode-map (kbd "C-x C-d") nil)
  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
  (define-key haskell-mode-map (kbd "C-c C-b") 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c M-.") nil)
  (define-key haskell-mode-map (kbd "C-c C-d") nil)

  ;; Switch to the REPL.
  (define-key haskell-mode-map [?\C-c ?\C-z] 'haskell-interactive-switch)
  ;; “Bring” the REPL, hiding all other windows apart from the source
  ;; and the REPL.
  (define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)

  ;; Build
  (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile)
  ;; Interactively choose the Cabal command to run.
  (define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
  (define-key haskell-mode-map (kbd "C-c v c") 'haskell-cabal-visit-file)

  ;; Get the type and info of the symbol at point, print it in the
  ;; message buffer.
  (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)

  ;; Contextually do clever things on the space key, in particular:
  ;;   1. Complete imports, letting you choose the module name.
  ;;   2. Show the type of the symbol after the space.
  (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)

  ;; Jump to the imports. Keep tapping to jump between import
  ;; groups. C-u f8 to jump back again.
  (define-key haskell-mode-map [f8] 'haskell-navigate-imports)

  ;; Jump to the definition of the current symbol.
  (define-key haskell-mode-map (kbd "M-.") 'haskell-mode-tag-find)

  ;; Indent the below lines on columns after the current column.
  (define-key haskell-mode-map (kbd "C-," 'haskell-move-nested-left))
  ;; Same as above but backwards.
  (define-key haskell-mode-map (kbd "C-." 'haskell-move-nested-right)))

;; Useful to have these keybindings for .cabal files, too.
(defun haskell-cabal-hook ()
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)
  (define-key haskell-cabal-mode-map (kbd "C-`") 'haskell-interactive-bring)
  (define-key haskell-cabal-mode-map [?\C-c ?\C-z] 'haskell-interactive-switch))
