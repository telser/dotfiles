;;; base -- Sumary

;;; Commentary:
; Various bits have been taken from emacs-prelude init.el, spacemacs,
; better-defaults.el(https://github.com/technomancy/better-defaults),
; github.com/bbastov/prelude and probably others that I cannot recall

;;; Code:

(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;;;;;;;;;;;;;;;;;;;;;;;;;;; Settings start here ;;;;;;;;;;;;;;;;;;;;;;;;

;;;; Basic Defaults

;;; set some vars
;; gc every 25MB (NOT 25MiB) default is supposed to be 0.76
(setq gc-cons-threshold 25000000)

(setq create-lockfiles nil)

(setq save-interprogram-paste-before-kill t)

;;; aliases
;; stop making me type
(defalias 'yes-or-no-p 'y-or-n-p)

;;; generic add-hooks

;; Whitespace BAD
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq-default indent-tabs-mode nil)

;;; Misc. mode on/off switches
(desktop-save-mode -1)
(global-flycheck-mode -1)
(save-place-mode 1)
(persp-mode 1)

;; enable periodic cleanup
(require 'midnight)

;;;;; Package configurations

;;;; use ido vertically, and everywhere, replace find-files with ido-find-file
(ido-mode 1)
(setq ido-enable-flex-matching t)
;; (ido-everywhere 1)
(ido-vertical-mode +1)
(setq ido-vertical-show-count t)
(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)
(require 'ido-completing-read+)
(ido-ubiquitous-mode 1)
(global-set-key (kbd "C-x C-f") 'ido-find-file)

;;;; company mode
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(company-quickhelp-mode 1)
(diminish 'company-mode)

;;;; which-key mode aka show me the keybindings!
(which-key-mode 1)
(diminish 'which-key-mode)

;;;; syntax-subword-mode
(diminish 'syntax-subword-mode)
(global-syntax-subword-mode 1)
(setq-default syntax-subword-skip-spaces 1)

;;;; tramp mode
(setq tramp-default-method "ssh")

;; undo tree
(require 'undo-tree)
(diminish 'undo-tree-mode)
(global-undo-tree-mode)

;;; expand region
(global-set-key (kbd "C-=") 'er/expand-region)

;;; smex
;; TODO: make smex show the keybinding for commands like helm-M-x does
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "H-m") 'smex-major-mode-commands)

;;; helm
; keep helm-M-x around
(global-set-key (kbd "H-x") 'helm-M-x)

;; projectile mode stuff
(projectile-mode)
(progn
  (define-prefix-command 'ring-map)
  (define-key ring-map (kbd "a") 'projectile-ag)
  (define-key ring-map (kbd "f") 'projectile-find-file)
  (define-key ring-map (kbd "r") 'projectile-replace-regexp)
  )
(global-set-key (kbd "H-p") ring-map)
(diminish 'projectile-mode)

;;; paredit
(require 'paredit)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)

;;; shells, inside emacs, not sh manip
(global-set-key (kbd "H-'") 'multi-term)

;;; other keybindings

(global-unset-key (kbd "M-ESC ESC"))

;; set the <f18> and <f19> keys to be hyper instead aka give me more modifiers!
(define-key key-translation-map (kbd "<f18>") 'event-apply-hyper-modifier)
(define-key key-translation-map (kbd "<next>") 'event-apply-hyper-modifier)
(define-key key-translation-map (kbd "<end>") 'event-apply-hyper-modifier)
(define-key key-translation-map (kbd "C-;") 'event-apply-hyper-modifier)
(define-key key-translation-map (kbd "M-n") 'event-apply-hyper-modifier)
(define-key key-translation-map (kbd "<f6>") 'event-apply-hyper-modifier)

;; use hippie expansion by default
(global-set-key (kbd "M-/") 'hippie-expand)

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

;; use helpful package over built-in help
(global-set-key (kbd "C-h f") #'helpful-callable)
(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)

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

;;;; Finding files
;(require-packages '(find-file-in-project))

;; (require-packages '(helm helm-ag helm-ag-r helm-cmd-t helm-dash
;;                          helm-descbinds helm-dired-recent-dirs
;;                          helm-flycheck helm-flymake helm-git
;;                          helm-git-files helm-git-grep helm-helm-commands
;;                          helm-projectile helm-themes helm-swoop))


(provide 'base)
;;;  base.el ends here
