;;; base --- Summary
;;; Commentary:
;;; base customizations and packages to use

;;; Code:


;; on recompile refresh the package contents and make sure use-package and diminish are installed
(package-refresh-contents t)
(dolist (package '(use-package diminish))
    (unless (package-installed-p package)
       (package-install package)))
(require 'use-package)
(require 'diminish)

(defalias 'yes-or-no-p 'y-or-n-p) ; answer with y/n instead of yes/no
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq create-lockfiles nil) ; stop creating .# lockfiles

;; Whitespace BAD
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; reload files when changed on disk
(global-auto-revert-mode +1)

;(desktop-save-mode 1)

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
   ("k" . projectile-kill-buffers)
   ("r" . projectile-replace-regexp)))

(use-package projectile
  :ensure t
  :diminish
  :config (projectile-mode +1)
  :bind
  (("C-c C-p" . projectile-command-map)))

; Make sure we have ag and ripgrep for searching (why both? habit, that is all)
(use-package ag
  :ensure t
  :diminish)

(use-package rg
  :ensure t
  :diminish)

(use-package beacon
  :ensure t
  :diminish
  :config (beacon-mode +1))

; undo tree allows for a nice undo/redo tree view
(use-package undo-tree
  :ensure t
  :diminish
  :config (global-undo-tree-mode 1)
          (setq undo-tree-auto-save-history 'nil))

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
  (setq lsp-enable-snippet nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  )

(use-package lsp-ui
  :ensure t)

(use-package lsp-treemacs
  :ensure t)

(use-package vterm
  :ensure t)

(use-package yasnippet
  :ensure t
  :diminish
  :config
  (yas-global-mode nil))

(use-package s
  :ensure t)

(use-package markdown-mode
  :ensure t
  :bind
  (:map markdown-mode-map
	("M-<up>" . markdown-move-up)
	("M-<down>" . markdown-move-down)))

;; alignment keybindings
(define-prefix-command 'align-global-keymap 'align-stuff)
(global-set-key (kbd "C-c a") 'align-global-keymap)
(define-key 'align-global-keymap (kbd "a") 'align)
(define-key 'align-global-keymap (kbd "c") 'align-current)
(define-key 'align-global-keymap (kbd "e") 'align-entire)
(define-key 'align-global-keymap (kbd "r") 'align-regexp)

;; regex for aligning by comma inside of a delimiter \(\s-+\)\(,\|\s(\|\s)\)

(defun er-remove-elc-on-save ()
  "Remove bytecompiled version of elisp files on save."
  (add-hook 'after-save-hook
	    (lambda ()
	      (if (file-exists-p (concat buffer-file-name "c"))
		  (delete-file (concat buffer-file-name "c"))))
	    nil
	    t))

(add-hook 'emacs-lisp-mode-hook 'er-remove-elc-on-save)

(defun toggle-camelcase-underscores (first-lower-p)
  "Toggle between camelcase and underscore notation for the
symbol at point. If prefix arg, C-u, is supplied, then make first
letter of camelcase lowercase."
  (interactive "P")
  (save-excursion
    (let* ((bounds (bounds-of-thing-at-point 'symbol))
           (start (car bounds))
           (end (cdr bounds))
           (currently-using-underscores-p (progn (goto-char start)
                                                 (re-search-forward "_" end t))))
      (if currently-using-underscores-p
          (progn
            (replace-string "_" " " nil start end)
            (upcase-initials-region start end)
            (replace-string " " "" nil start end)
            (when first-lower-p
              (downcase-region start (1+ start))))
        (replace-regexp "\\([A-Z]\\)" "_\\1" nil (1+ start) end)
        (downcase-region start (cdr (bounds-of-thing-at-point 'symbol)))))))

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match
that used by the user's shell.

This is particularly useful under Mac OS X and macOS, where GUI
apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string
			  "[ \t\n]*$" "" (shell-command-to-string
					  "$SHELL --login -c 'echo $PATH'"
						    ))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)

;;; undo-tree-history-directory-alist

(provide 'base)
;;; base.el ends here
