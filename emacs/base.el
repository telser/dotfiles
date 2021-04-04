;;; base -- Summary base setup

;;; Commentary:
;;; This is for everything to do with a base level setup

;;; Code:

(defalias 'yes-or-no-p 'y-or-n-p) ; answer with y/n instead of yes/no
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq create-lockfiles nil) ; stop creating .# lockfiles

;; Whitespace BAD
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; reload files when changed on disk
(global-auto-revert-mode +1)

(desktop-save-mode 1)

;; Install auto-package-update to make sure everything stays up to date
(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-prompt-before-update t)
  (auto-package-update-maybe))

; smex, allows for enhanced M-x used with in combination of ivy/counsel/swiper
(use-package smex
  :ensure t)

(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
	 ("C-x b" . helm-buffers-list)
	 ("C-x C-f" . helm-find-files))
  :diminish helm-mode
  :config
  (setq helm-split-window-inside-p t) ; always split helm in the current window rather than take over another split
  (helm-mode 1))

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
  :bind (("C-S-f" . syntax-subword-forward-syntax)
	 ("C-S-b" . syntax-subword-backward-syntax)))

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

(defun er-remove-elc-on-save ()
  "Remove bytecompiled version of elisp files on save"
  (add-hook 'after-save-hook
            (lambda ()
              (if (file-exists-p (concat buffer-file-name "c"))
                  (delete-file (concat buffer-file-name "c"))))
            nil
            t))

(add-hook 'emacs-lisp-mode-hook 'er-remove-elc-on-save)

(provide 'base)
