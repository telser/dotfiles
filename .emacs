;;; package --- Summary
;;; emacs init is there anymore to say?

;;; Commentary:
;;; Based on an init.el file from a coworker (not in public source control)
;;; TODO:this should probably be broken up into more files

;;; Code:

(defun imenu-elisp-sections ()
  (setq imenu-prev-index-position-function nil)
  (add-to-list 'imenu-generic-expression '("Sections" "^;;;; \\(.+\\)$" 1) t))

(add-hook 'emacs-lisp-mode-hook 'imenu-elisp-sections)

;;;; Basic Defaults

;;; Taken from emacs-prelude init.el

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; stop making me type
(defalias 'yes-or-no-p 'y-or-n-p)

;;; Stolen from better-defaults.el
;; https://github.com/technomancy/better-defaults

(ido-mode t)
(setq ido-enable-flex-matching t)

(unless (eq system-type 'darwin)
  (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)
(setq uniquify-strip-common-suffix t)

(require 'saveplace)
(setq-default save-place t)

(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      save-place-file (concat user-emacs-directory "places")
      backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))
(global-hl-line-mode +1)

(require 'midnight) ;; enable periodic cleanup

(global-unset-key (kbd "M-ESC ESC"))

;;;; ELPA Config

;;; add marmalade to package repos
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(defun require-package (package)
  "Ensure a PACKAGE is installed."
  (unless (package-installed-p package)
    (package-install package)))

(require-package 'projectile)

(defun require-packages (packages)
  "Ensure all PACKAGES are installed."
  (mapc #'require-package packages))

;;;; Prelude utility functions
;; Stolen from github.com/bbastov/prelude

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


;;;; Package configurations
;;; Basic packages

(column-number-mode)

(require-packages '(projectile ag change-inner diminish dash flycheck git-commit-mode
                               lusty-explorer magit paredit paredit-menu rainbow-delimiters
                               undo-tree yasnippet buffer-move window-jump
                               ace-jump-mode ace-jump-buffer ace-window
                               persp-mode workgroups2 smex sr-speedbar))
(require 'undo-tree)
(global-undo-tree-mode)
(diminish 'undo-tree-mode)

(require 'buffer-move)
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

(require 'window-jump)
(global-set-key (kbd "<C-up>")     'window-jump-up)
(global-set-key (kbd "<C-down>")   'window-jump-down)
(global-set-key (kbd "<C-left>")   'window-jump-left)
(global-set-key (kbd "<C-right>")  'window-jump-right)

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

;; C-c left, C-c right to undo/redo window changes
(winner-mode 1)

;;; Multiple cursors

(require-packages '(multiple-cursors))
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;;; Expand regaion

(require-packages '(expand-region))
(global-set-key (kbd "C-=") 'er/expand-region)

(global-set-key (kbd "M-F") 'forward-symbol)

;;; SMEX

(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;;; HELM

(require-packages '(helm helm-ag helm-ag-r helm-cmd-t helm-dash
                         helm-descbinds helm-dired-recent-dirs
                         helm-flycheck helm-flymake helm-git
                         helm-git-files helm-git-grep helm-helm-commands
                         helm-projectile helm-rails helm-themes helm-swoop))

; (global-set-key (kbd "C-x b") 'helm-buffers-list)
; (global-set-key (kbd "C-x C-f") 'helm-find-files)
; (global-set-key (kbd "M-x") 'helm-M-x)

(require 'helm-files)
(define-key helm-find-files-map (kbd "M-l") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "M-.") 'helm-execute-persistent-action)

(setq helm-completing-read-handlers-alist
      '((describe-function . helm-completing-read-symbols)
        (describe-variable . helm-completing-read-symbols)
        (debug-on-entry . helm-completing-read-symbols)
        (find-function . helm-completing-read-symbols)
        (find-tag . helm-completing-read-with-cands-in-buffer)
        (ffap-alternate-file . nil)
        (tmm-menubar . nil)
        (dired-do-copy . nil)
        (dired-do-rename . nil)
        (dired-create-directory . nil)
        (find-file . ido)
        (copy-file-and-rename-buffer . nil)
        (rename-file-and-buffer . nil)
        (w3m-goto-url . nil)
        (ido-find-file . nil)
        (ido-edit-input . nil)
        (mml-attach-file . ido)
        (read-file-name . nil)
        (yas/compile-directory . ido)
        (execute-extended-command . ido)
        (minibuffer-completion-help . nil)
        (minibuffer-complete . nil)
        (c-set-offset . nil)
        (wg-load . ido)
        (rgrep . nil)
        (read-directory-name . ido)
        ))

(projectile-global-mode)
(helm-mode 1)

(require 'helm-swoop)

(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'help-swoop-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-c M-I") 'helm-multi-swoop-all)

(global-set-key (kbd "C-x b") 'helm-buffers-list)

(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)

(cua-selection-mode nil)

(global-set-key (kbd "M-p") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;;; Paredit

(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'clojure-mode-hook 'enable-paredit-mode)

(require 'workgroups2)
(setq wg-use-default-session-file nil)
(workgroups-mode 1)

;; (with-eval-after-load "persp-mode-autoloads"
;;   (setq wg-morph-on nil)
;;   (add-hook 'after-init-hook #'(lambda () (persp-mode 1))))


;;;
;;; Customization Vars
;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(create-lockfiles nil)
 '(custom-enabled-themes (quote (deeper-blue)))
 '(custom-safe-themes
   (quote
    ("426947ad8a72b8c65e3d1b7bc7a2a8a69f52730fa683a66046bb56c937509b82" "f4e13810b9c0807ae33ffdbbf89d58d9bc57f68023c38f80596f423c3dace905" "b663810f3526eafecd7ed9c2b198d8ae85a3c36361dcb0755453d05c5e1c8813" "1947bcec0a569caa4ada36a0ddbe90c8ba77899a0f827ffc037371a7397012dd" "fc2782b33667eb932e4ffe9dac475f898bf7c656f8ba60e2276704fabb7fa63b" "bec974465f6d41cddd2ca0a27db10203b0391be960216bbed0623acd7b67cf20" "58cffa855f737ecd1424bdc7667e0aa5996a240d918a30519048fb8beface779" "0e79dac2b2eeb2f4e7c66ebfd6e8a3449ff885cbbf1dfdd79de1d097238721e7" "4d895375d4b7a917789ef26e4ea14c7bc8db5ace925c1340c5515a056d541afe" "49b6d86f398c9bdfebcba8fc5dbbb0b30eb70cfbbd820b8b11e5b06bcb87dad0" "375a7829519deb7d8123ed3936ca067d944e91b19486a89268f7576d65549d25" "6994955bc4275b64f3bbb1f58cb631727c0a43f4361ee9e8afb60f6ded53baa0" "758da0cfc4ecb8447acb866fb3988f4a41cf2b8f9ca28de9b21d9a68ae61b181" default)))
 '(default-frame-alist
    (quote
     ((vertical-scroll-bars)
      (width . 130)
      (height . 80))))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(flymake-xml-program "xmllint")
 '(haskell-notify-p t)
 '(haskell-stylish-on-save t)
 '(haskell-tags-on-save t)
 '(helm-ff-auto-update-initial-value t)
 '(helm-move-to-line-cycle-in-source t)
 '(js2-highlight-level 3)
 '(magit-emacsclient-executable "/usr/local/bin/emacsclient")
 '(magit-gitk-executable (quote gitk))
 '(ruby-deep-arglist nil)
 '(winner-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;
;;; Web mode
;;;

(require-package 'web-mode)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(defun web-mode-seutp ()
  "Configuration for web-mode."
  (electric-indent-mode +1)
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 4)
  (local-set-key (kbd "RET") 'new-line-and-indent))

(add-hook 'web-mode-hook 'web-mode-setup)

(global-font-lock-mode 1)
(setq font-lock-maximum-decoration 1)

;;; Font lock

;; Add TODO, etc to recognized keywords
(font-lock-add-keywords
   nil '(("\\<\\(\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):\\)"
          1 font-lock-warning-face t)))

;;; Show function name on modeline
(require 'which-func)
(add-to-list 'which-func-modes 'ruby-mode)
(which-function-mode 1)


;;;
;;; Haskell Mode
;;;

(require-packages '(haskell-mode shm flymake-hlint))

(require 'haskell-mode-autoloads)
;; (speedbar-add-supported-extension ".hs")
(require 'shm)

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


;;;; Clojure mode setup

(require-packages '(clojure-mode cider typed-clojure-mode
                                 clojure-snippets clojurescript-mode))

(require 'clojure-mode)
(require 'cider)
(require 'rainbow-delimiters)

(defun clojure-mode-setup ()
  (electric-indent-mode +1)
  (subword-mode +1)
  (clojure-test-mode +1)
  (rainbow-delimiters-mode +1))

(defun cider-mode-setup ()
  (rainbow-delimiters-mode +1)
  (subword-mode +1)
  (whitespace-mode -1))

(add-hook 'cider-repl-mode-hook 'cider-mode-setup)


;;;; Emacs lisp mode

(defun recompile-elisp ()
  "Recompile the current elisp buffer."
  (when (file-exists-p (byte-compile-dest-file buffer-file-name))
    (emacs-lisp-byte-compile)))

(defun recompile-elisp-on-save ()
  "Recompile elisp file when saving."
  (add-hook 'after-save-hook 'recompile-elisp nil t))

(defun elisp-mode-setup ()
  "Settings for elisp mode."
  (turn-on-eldoc-mode)
  (rainbow-delimiters-mode +1)
  (recompile-elisp-on-save)
  (setq mode-name "EL"))

(add-hook 'emacs-lisp-mode-hook 'elisp-mode-setup)

;;;; Ruby Mode

(require-packages '(ruby-mode yari ruby-tools))

(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.thor\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Thorfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.jbuilder\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Podfile\\'" . ruby-mode))

(add-to-list 'completion-ignored-extensions ".rbc")

(defun ruby-setup ()
  "Settings for ruby mode."
  (inf-ruby-minor-mode +1)
  (ruby-tools-mode +1)
  (subword-mode +1))

(add-hook 'ruby-mode-hook 'ruby-setup)

;;; Javascript

(require-packages '(js2-mode js2-refactor ac-js2))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

(js2r-add-keybindings-with-prefix "C-c C-j")

;;; PHP

(require-packages '(php-mode phpunit php-eldoc))
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))


;; Get ride of trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; Start the emacsclient server

(server-start)

(provide '.emacs)
;;; .emacs ends here
