;;; base -- Sumary

;;; Commentary:
; Various bits have been taken from emacs-prelude init.el, spacemacs,
; better-defaults.el(https://github.com/technomancy/better-defaults),
; github.com/bbastov/prelude and probably others that I cannot recall

;;; Code:

;;;; ELPA Config
(package-initialize)

(defun require-package (package)
  "Install a PACKAGE."
  (unless (package-installed-p package)
    (package-install package)))

(defun require-packages (packages)
  "Install a list of PACKAGES."
  (mapc #'require-package packages))

;;;;;;;;;;;;;;;;;;;;;;;;;;; Settings start here ;;;;;;;;;;;;;;;;;;;;;;;;

;;;; Basic packages
(require-packages '(projectile ;; per project file finding and so forth
                    ag ;; because ag is so much faster at searches
                    change-inner
                    color-theme-modern ;; color themes and a framework for them
                    diminish ;; diminished modes do not show up on the modeline, SO USEFUL
                    darkokai-theme ;; my current favorite theme, like monokai but darker
                    dash
                    fic-mode ;; show fixme, etc in special faces
                    flycheck ;; who doesn't want on the fly checking?
                    lusty-explorer yasnippet persp-mode
                               sr-speedbar
                               ))

;; TODO: investigate using these packages more
(require-packages '(helpful))

;; Use emacs for everything.. TODO: try these out:
(require-packages '(slack znc))

;;;; Basic Defaults

;;; set some vars

(setq-default indent-tabs-mode nil)
;; gc every 25MB (NOT 25MiB) default is supposed to be 0.76
(setq gc-cons-threshold 25000000)
(set-face-attribute 'default nil :family "Hack")
(setq create-lockfiles nil)

;; Bell is annoying the crap out of me..
(setq ring-bell-function 'ignore)

(setq save-interprogram-paste-before-kill t)

;;; aliases

;; stop making me type
(defalias 'yes-or-no-p 'y-or-n-p)

;;; generic add-hooks

;; Whitespace BAD
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; Misc. mode on/off switches

(show-paren-mode 1)
;; no need for the menubar, give back that vertical space please
(menu-bar-mode -1)
;; no need for toolbar, give back that vertical space
(tool-bar-mode -1)
(desktop-save-mode 1)
(global-flycheck-mode 1)
;; show line numbers on the left but not in the modeline(hide columns from there too)
(global-hl-line-mode 1)
(global-linum-mode 1)
(column-number-mode 1)
(line-number-mode -1)
(save-place-mode 1)
(persp-mode 1)
;; C-c left, C-c right to undo/redo window changes
(winner-mode 1)

;;; Additional requires

;; enable periodic cleanup
(require 'midnight)

;;;;; Package configurations

;;;; RAINBOWS!
(require-packages '(rainbow-delimiters rainbow-identifiers rainbow-mode))
(diminish 'rainbow-mode)
(defun rainbow-hook ()
  "All the RAINBOWS."
  (rainbow-mode 1)
  (fic-mode 1)
  (rainbow-delimiters-mode 1)
  (rainbow-identifiers-mode 1)
  (diminish 'rainbow-mode))
;; There is no global mode for rainbows, so turn it on for *most* programming modes.
(add-hook 'prog-mode-hook #'rainbow-hook)

;;;; use ido vertically, and everywhere, replace find-files with ido-find-file

(ido-mode 1)
(require-packages '(ido-vertical-mode ido-completing-read+))
(setq ido-enable-flex-matching t)
(ido-everywhere 1)
(ido-vertical-mode +1)
(setq ido-vertical-show-count t)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(require 'ido-completing-read+)
(ido-ubiquitous-mode 1)
(global-set-key (kbd "C-x C-f") 'ido-find-file)

;;;; Finding files
(require-packages '(find-file-in-project))

;;;; company mode

(require-packages '(company company-dict company-quickhelp company-shell company-statistics))
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(company-quickhelp-mode 1)
(diminish 'company-mode)

;;;; which-key mode aka show me the keybindings!

(require-packages '(which-key))
(which-key-mode 1)
(diminish 'which-key-mode)

;;;; syntax-subword-mode

(require-package 'syntax-subword)
(diminish 'syntax-subword-mode)
(global-syntax-subword-mode 1)
(setq-default syntax-subword-skip-spaces 1)

;;;; tramp mode
(require-package 'tramp)
(setq tramp-default-method "ssh")
;; (eval-after-load 'tramp '(setenv "SHELL" "/bin/zsh"))

;; undo tree
(require-package 'undo-tree)
(require 'undo-tree)
(diminish 'undo-tree-mode)
(global-undo-tree-mode)

;;; expand region

(require-packages '(expand-region))
(global-set-key (kbd "C-=") 'er/expand-region)

;;; smex

;; TODO: make smex show the keybinding for commands like helm-M-x does
(require-package 'smex)
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;;; helm

(require-packages '(helm helm-ag helm-ag-r helm-cmd-t helm-dash
                         helm-descbinds helm-dired-recent-dirs
                         helm-flycheck helm-flymake helm-git
                         helm-git-files helm-git-grep helm-helm-commands
                         helm-projectile helm-rails helm-themes helm-swoop))
; keep helm-M-x around
(global-set-key (kbd "M-s") 'helm-M-x)

(projectile-global-mode)
(diminish 'projectile-mode)
(helm-mode 1)
(diminish 'helm-mode)
(require 'helm-swoop)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'help-swoop-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-c M-I") 'helm-multi-swoop-all)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)

;;; ace window

(require-packages '(ace-jump-mode ace-jump-buffer ace-window))
(global-set-key (kbd "H-a") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;;; paredit

(require-packages '(paredit paredit-menu))
(require 'paredit)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)

;;; font lock

(global-font-lock-mode 1)
(setq font-lock-maximum-decoration 1)

;; Add TODO:  etc to recognized keywords for font lock
(font-lock-add-keywords
   nil '(("\\<\\(\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):\\)"
          1 font-lock-warning-face t)))

;;; shells, inside emacs, not sh manip

(require-packages '(multi-term multishell))
(global-set-key (kbd "H-'")      'multi-term)

;;; window/buffer movement and keybindings

(require-packages '(buffer-move window-jump))

;; move the current buffer around the 'pane'
(require 'buffer-move)
(global-set-key (kbd "<C-s-up>")     'buf-move-up)
(global-set-key (kbd "<C-s-down>")   'buf-move-down)
(global-set-key (kbd "<C-s-left>")   'buf-move-left)
(global-set-key (kbd "<C-s-right>")  'buf-move-right)

;; move to another buffer in the current 'pane'
(require 'window-jump)
(global-set-key (kbd "<s-up>")     'window-jump-up)
(global-set-key (kbd "H-p")      'window-jump-up)
(global-set-key (kbd "<s-down>")   'window-jump-down)
(global-set-key (kbd "H-n")      'window-jump-down)
(global-set-key (kbd "<s-left>")   'window-jump-left)
(global-set-key (kbd "H-l")      'window-jump-left)
(global-set-key (kbd "<s-right>")  'window-jump-right)
(global-set-key (kbd "H-r")      'window-jump-right)

(global-set-key (kbd "C-H-d")      'delete-window)
(global-set-key (kbd "C-H-r")      'split-window-right)
(global-set-key (kbd "C-H-b")      'split-window-below)

;; make sure paredit doesn't clash with the above
(require 'paredit)
(define-key paredit-mode-map (kbd "<C-up>") nil)
(define-key paredit-mode-map (kbd "<C-down>") nil)
(define-key paredit-mode-map (kbd "<C-left>") nil)
(define-key paredit-mode-map (kbd "<C-right>") nil)
(define-key paredit-mode-map (kbd "<M-up>") nil)
(define-key paredit-mode-map (kbd "<M-down>") nil)
(define-key paredit-mode-map (kbd "<M-left>") nil)
(define-key paredit-mode-map (kbd "<M-right>") nil)
(define-key paredit-mode-map (kbd "<C-M-up>") nil)
(define-key paredit-mode-map (kbd "<C-M-down>") nil)
(define-key paredit-mode-map (kbd "<C-M-left>") nil)
(define-key paredit-mode-map (kbd "<C-M-right>") nil)
(define-key paredit-mode-map (kbd "ESC-<right>") nil)
(define-key syntax-subword-mode-map (kbd "<ESC right>") nil)

;;; other keybindings

(global-unset-key (kbd "M-ESC ESC"))

;; set the <f18> and <f19> keys to be hyper instead aka give me more modifiers!
(define-key key-translation-map (kbd "<f18>") 'event-apply-hyper-modifier)
(define-key key-translation-map (kbd "<next>") 'event-apply-hyper-modifier)
(define-key key-translation-map (kbd "<end>") 'event-apply-hyper-modifier)
(define-key key-translation-map (kbd "C-;") 'event-apply-hyper-modifier)
(define-key key-translation-map (kbd "<f6>") 'event-apply-hyper-modifier)

;; use hippie expansion by default
(global-set-key (kbd "M-/") 'hippie-expand)

;; shortcut for ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; search shortcuts
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "H-s") 'query-replace-regexp)

;; bindings for utility functions
(global-set-key (kbd "H-j") 'join-line-forward)
(global-set-key (kbd "H-k") 'kill-region)
(global-set-key (kbd "H-o") 'smart-open-line-above)

;;;; Utility Functions

(defadvice kill-ring-save (before smart-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
   (interactive
   (if mark-active (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position)
           (line-end-position)))))

(defadvice kill-region (before smart-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

(defun smart-open-line-above ()
  "Insert an empty line above the current line.
Position cursor at it's beginning according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(defun join-line-forward ()
  "Join a line with the line beneath it."
  (interactive)
  (forward-line 1)
  (delete-indentation 1))

(defun indent-buffer ()
  "Indent the entire buffer according to mode."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun rename-file-and-buffer ()
  "Rename the current buffer and the file that it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file.")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(defun delete-file-and-buffer ()
  "Delete the current buffer and the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (when (y-or-n-p (format "Are you sure you want to delete %s? " filename))
          (delete-file filename)
          (message "Deleted file %s." filename)
          (kill-buffer))))))

(defun untabify-buffer ()
  "Remove all tabs from the current buffer."
  (interactive)
  (untabify (point-min) (point-max)))

(defun cleanup-buffer ()
  "Untabify, indent, and clean whitespace in buffer."
  (interactive)
  (indent-buffer)
  (untabify-buffer)
  (whitespace-cleanup))

(defun imenu-elisp-sections ()
  "Elisp sections in imenu."
  (setq imenu-prev-index-position-function nil)
  (add-to-list 'imenu-generic-expression '("Sections" "^;;;; \\(.+\\)$" 1) t))

;;; Cruft that is not currently in use, but probably was at some point or another...
;;; TODO: Go through all this crap

;;; Multiple cursors

;; (require-packages '(multiple-cursors))
;; (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; (require 'helm-files)
;; (define-key helm-find-files-map (kbd "M-l") 'helm-execute-persistent-action)
;; (define-key helm-find-files-map (kbd "M-.") 'helm-execute-persistent-action)
;; (setq helm-completing-read-handlers-alist
;;       '((describe-function . helm-completing-read-symbols)
;;         (describe-variable . helm-completing-read-symbols)
;;         (debug-on-entry . helm-completing-read-symbols)
;;         (find-function . helm-completing-read-symbols)
;;         (find-tag . helm-completing-read-with-cands-in-buffer)
;;         (ffap-alternate-file . nil)
;;         (tmm-menubar . nil)
;;         (dired-do-copy . nil)
;;         (dired-do-rename . nil)
;;         (dired-create-directory . nil)
;;         (find-file . ido)
;;         (copy-file-and-rename-buffer . nil)
;;         (rename-file-and-buffer . nil)
;;         (w3m-goto-url . nil)
;;         (ido-find-file . nil)
;;         (ido-edit-input . nil)
;;         (mml-attach-file . ido)
;;         (read-file-name . nil)
;;         (yas/compile-directory . ido)
;;         (execute-extended-command . ido)
;;         (minibuffer-completion-help . nil)
;;         (minibuffer-complete . nil)
;;         (c-set-offset . nil)
;;         (wg-load . ido)
;;         (rgrep . nil)
;;         (read-directory-name . ido)
;;         ))
;; (require 'uniquify)
;; (setq uniquify-buffer-name-style 'post-forward)
;; (setq uniquify-strip-common-suffix t)
;; (fset 'del-underscore
;;       (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("_" 0 "%d")) arg)))
;; (add-to-list 'auto-mode-alist (cons "\\.purs\\'" 'purescript-mode))
;; (setq exec-path (cons "~/.local/bin" exec-path))
;; (setq
;;       x-select-enable-primary t
;;       apropos-do-all t)
;(add-hook 'emacs-lisp-mode-hook 'imenu-elisp-sections)
;; ;;; Show function name on modeline
;; (require 'which-func)
;; (add-to-list 'which-func-modes 'ruby-mode)
;; (which-function-mode 1)

(provide 'base)
;;;  base.el ends here
