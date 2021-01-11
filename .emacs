(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(eval-when-compile
  (package-refresh-contents)
  (package-install 'use-package) ; everything else will be installed/configured with use-package
  (package-install 'diminish) ; use-package can take advantage of diminish to remove minor modes fro the modeline
  (require 'use-package)
  (require 'diminish))

(defalias 'yes-or-no-p 'y-or-n-p) ; answer with y/n instead of yes/no
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq create-lockfiles nil) ; stop creating .# lockfiles

; base level stuff, commands/search

; smex, allows for enhanced M-x used with in combination of ivy/counsel/swiper
(use-package smex
  :ensure t)

; ivy completion mechanism used by a bunch of other stuff
(use-package ivy
  :ensure t
  :diminish
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t))

; counsel provides versions of basic emacs commands that make better use of ivy
(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file)))

;; swiper is an isearch replacement that shows a list of matches
;; but reverse searching seems to not be working for some reason, so back to isearch it is
;; (use-package swiper
;;   :ensure t
;;   :bind (("\C-s" . swiper)
;; 	 ("\C-r" . swiper-backward)))

; undo tree allows for a nice undo/redo tree view
(use-package undo-tree
  :ensure t
  :diminish
  :config (global-undo-tree-mode 1))

(use-package syntax-subword
  :ensure t
  :config (global-syntax-subword-mode 1))

(use-package smartparens
  :ensure t
  :hook (prog-mode . smartparens-mode))

; which-key mode aka show me the keybindings!
(use-package which-key
  :ensure t
  :diminish
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

;; compile the child configuration files
(byte-recompile-directory (expand-file-name "~/emacs") 0)
(add-to-list 'load-path "~/emacs")
(load-library "display")
(load-library "buffer")

;;; projectile for project level search and such
(use-package counsel-projectile
  :ensure t
  :bind-keymap
  ("C-c p" . projectile-command-map))

;; language stuff
(use-package dhall-mode
  :ensure t)
(use-package haskell-mode
  :ensure t)
(use-package irony
  :ensure t)
(use-package lua-mode
  :ensure t)
(use-package yaml-mode
  :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(syntax-subword smartparens counsel-projectile command-log-mode smex counsel ivy diminish use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
