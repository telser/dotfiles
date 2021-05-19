;;; emacsconfig  --- Summary

;;; Commentary:
;;; what is there to say? It's a config
;;; Code:
(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; on recompile refresh the package contents and make sure use-package and diminish are installed
(eval-when-compile
  (package-refresh-contents)
  (dolist (package '(use-package diminish))
    (unless (package-installed-p package)
       (package-install package)))
  (require 'use-package)
  (require 'diminish))


(defalias 'yes-or-no-p 'y-or-n-p) ; answer with y/n instead of yes/no
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq create-lockfiles nil) ; stop creating .# lockfiles

;; Whitespace BAD
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; reload files when changed on disk
(global-auto-revert-mode +1)

(desktop-save-mode 1)

; smex, allows for enhanced M-x used with in combination of ivy/counsel/swiper
(use-package smex
  :ensure t)

(use-package helm
  :ensure t
  :demand
  :bind (("M-x" . helm-M-x)
	 ("C-x b" . helm-buffers-list)
	 ("C-x C-f" . helm-find-files)
	 :map helm-find-files-map
	 ("TAB" . helm-execute-persistent-action)
	 )
  :diminish helm-mode
  :config
  (setq helm-split-window-inside-p t) ; always split helm in the current window rather than take over another split
  (helm-mode 1))

(use-package helm-ag
  :ensure t
  :diminish)

(use-package helm-projectile
  :ensure t
  :init (define-prefix-command 'helm-projectile-map)
  :diminish
  :bind
  (("C-c p" . helm-projectile-map)
   ("H-p" . helm-projectile-map)
   :map helm-projectile-map
   ("a" . helm-projectile-ag)
   ("f" . helm-projectile-find-file)
   ("r" . projectile-replace-regexp)))

; undo tree allows for a nice undo/redo tree view
(use-package undo-tree
  :ensure t
  :diminish
  :config (global-undo-tree-mode 1))

(use-package syntax-subword
  :ensure t
  :config (global-syntax-subword-mode 1)
  :demand
  :bind (("C-S-f" . syntax-subword-forward-syntax)
	 ("C-S-b" . syntax-subword-backward-syntax)))

; which-key mode aka show me the keybindings!
(use-package which-key
  :ensure t
  :diminish
  :demand
  :config (which-key-mode 1))

; command-log-mode to show what is being performed, useful for pairing
(use-package command-log-mode
  :ensure t
  :diminish
  :config
  (global-command-log-mode 1)
  (clm/open-command-log-buffer))

; helpful provides more contextual information so set it as default
(use-package helpful
  :ensure t
  :bind (("C-h f" . helpful-callable)
	 ("C-h k" . helpful-key)
	 ("C-h v" . helpful-variable)))

; company provides generic autocomplete that is extended for pretty much everything
(use-package company
  :ensure t
  :diminish
  :config (global-company-mode 1))

(use-package flycheck
  :ensure t
  :config
  (define-key flycheck-mode-map flycheck-keymap-prefix nil)
  (setq flycheck-keymap-prefix (kbd "C-c f"))
  (define-key flycheck-mode-map flycheck-keymap-prefix flycheck-command-map)
  (global-flycheck-mode))

(use-package lsp-mode
  :ensure t
  :bind-keymap (("C-c l" . lsp-command-map))
  :config
  (let ((lsp-keymap-prefix "C-c l")) (lsp-enable-which-key-integration t))
  )

(use-package lsp-ui
  :ensure t)

(defun er-remove-elc-on-save ()
  "Remove bytecompiled version of elisp files on save."
  (add-hook 'after-save-hook
	    (lambda ()
	      (if (file-exists-p (concat buffer-file-name "c"))
		  (delete-file (concat buffer-file-name "c"))))
	    nil
	    t))

(add-hook 'emacs-lisp-mode-hook 'er-remove-elc-on-save)

;; compile the child configuration files
(byte-recompile-directory (expand-file-name "~/emacs") 0)
(add-to-list 'load-path "~/emacs")
(load-library "display")
(load-library "buffer")

;; language stuff
(use-package dhall-mode
  :ensure t)

(use-package haskell-mode
  :ensure t
  :config
  (setq haskell-tags-on-save t)
  (defun haskell-sort-imports-on-save-hook ()
    (when (eq major-mode 'haskell-mode)
      (haskell-sort-imports)))
  (add-hook 'before-save-hook #'haskell-sort-imports-on-save-hook))

(use-package docker-compose-mode
  :ensure t)

(use-package dockerfile-mode
  :ensure t)

(use-package gitlab-ci-mode
  :ensure t)

(use-package irony
  :ensure t)
(use-package lua-mode
  :ensure t)
(use-package yaml-mode
  :ensure t)

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(use-package lsp-haskell
  :ensure t
  ;; :init
  ;; (add-hook 'haskell-mode-hook #'lsp)
  :config
  (setq lsp-enable-file-watchers nil))

(use-package flycheck-haskell
  :ensure t
  :config
  (add-hook 'haskell-mode-hook #'flycheck-haskell-setup))

(add-hook 'hack-local-variables-hook (lambda () (when (derived-mode-p 'haskell-mode) (lsp))))

(use-package xml-format
  :ensure t
  :config (xml-format-on-save-mode))
(use-package xml+
  :ensure t)

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
   '(gitlab-ci-mode dockerfile-mode docker-compose-mode zoom-window window-number windresize window-jump buffer-move darkokai-theme helm-ag syntax-subword command-log-mode smex diminish use-package))
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
