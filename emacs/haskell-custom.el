;;; haskell-custom --- Summary
;;; Commentary:
;;; haskell-mode customizations

;;; Code:

(require 'use-package)

(use-package haskell-mode
  :ensure t
  :init (define-prefix-command 'haskell-keymap)
  :config
  (defun haskell-sort-imports-on-save-hook ()
    (when (eq major-mode 'haskell-mode)
      (haskell-sort-imports)))
  (add-hook 'before-save-hook #'haskell-sort-imports-on-save-hook)

  ;; add some alignment rules for haskell so the align* commands play nice
  (defun add-haskell-align-rules-hook ()
    "Add alignment rules."
    (eval-after-load 'align
      '(when (eq major-mode 'haskell-mode)
	(add-to-list 'align-rules-list
		     '(haskell-types
		       (regexp . "\\(\\s-+\\)\\(::\\|∷\\)\\s-+")
		       ('(haskell-mode))))

	(add-to-list 'align-rules-list
		     '(haskell-comma
		       (regexp . "\\(\\s-+\\)\\(,\|\s(\|\s)\\)\\s-+")
		       ('(haskell-mode))))

	(add-to-list 'align-rules-list
		     '(haskell-assignment
		       (regexp . "\\(\\s-+\\)=\\s-+")
		       ('(haskell-mode))))

	(add-to-list 'align-rules-list
		     '(haskell-arrows
		       (regexp . "\\(\\s-+\\)\\(->\\|→\\)\\s-+")
		       ('(haskell-mode)))))
    ))
  (add-hook 'haskell-mode-hook 'add-haskell-align-rules-hook)
  :bind
  (("C-c h" . haskell-keymap)
   :map haskell-keymap
   ("p" . haskell-command-insert-language-pragma))
  )

(use-package lsp-haskell
  :ensure t
  ;; :init
  ;; (add-hook 'haskell-mode-hook #'lsp)
  :config
  (setq lsp-enable-file-watchers nil)
  (setq lsp-haskell-refineimports-on nil)
;  (setq lsp-haskell-importlens-on nil)
  )

(use-package flycheck-haskell
  :ensure t
  :config
  (add-hook 'haskell-mode-hook #'flycheck-haskell-setup))

(add-hook 'hack-local-variables-hook (lambda () (when (derived-mode-p 'haskell-mode) (lsp))))
