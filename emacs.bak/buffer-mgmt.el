;;; buffer-mgmt -- Sumary settings and keys for buffer management

;;; Commentary:
;;; This includes all settings and keybindings for managing buffers and windows.
;;; Things such as winner-mode, ibuffer, helm-buffer, buffer/window movement, etc are here

;;; Code:

(winner-mode 1) ;; C-c left, C-c right to undo/redo window changes

;; Helm and ido settings/shortcuts
(global-set-key (kbd "C-x C-b") 'ibuffer) ;; ibuffer is good at managing buffers
(helm-mode 1) ;; turn helm mode on
(diminish 'helm-mode) ;; no need to display helm
(global-set-key (kbd "C-x b") 'helm-buffers-list) ;; helm is good for fast switching buffers

;; move the current buffer around the 'pane'
(eval-after-load 'buffer-move
  (progn
    (global-set-key (kbd "<C-s-up>") 'buf-move-up)
    (global-set-key (kbd "<C-s-down>") 'buf-move-down)
    (global-set-key (kbd "<C-s-left>") 'buf-move-left)
    (global-set-key (kbd "<C-s-right>") 'buf-move-right)))

;; move to another buffer in the current 'pane'
(eval-after-load 'window-jump
  (progn
    (define-prefix-command 'window-keymap)
    (global-set-key (kbd "H-w") 'window-keymap)
    (define-key window-keymap (kbd "p") 'window-jump-up)
    (define-key window-keymap (kbd "n") 'window-jump-down)
    (define-key window-keymap (kbd "l") 'window-jump-left)
    (define-key window-keymap (kbd "r") 'window-jump-right)))

;; deleting and splitting windows
(global-set-key (kbd "C-H-d") 'delete-window)
(global-set-key (kbd "C-H-r") 'split-window-right)
(global-set-key (kbd "C-H-b") 'split-window-below)

;; make sure paredit doesn't clash with the above
(eval-after-load 'paredit
  (progn
    (define-key paredit-mode-map (kbd "<C-up>") nil)
    (define-key paredit-mode-map (kbd "<C-down>") nil)
    (define-key paredit-mode-map (kbd "<C-left>") nil)
    (define-key paredit-mode-map (kbd "<C-right>") nil)
    (define-key paredit-mode-map (kbd "<M-up>") nil)
    (define-key paredit-mode-map (kbd "<M-down>") nil)
    (define-key paredit-mode-map (kbd "<M-left>") nil)
    (define-key paredit-mode-map (kbd "<M-right>") nil)))
(define-key syntax-subword-mode-map (kbd "<ESC right>") nil)
;;; buffer-mgmt.el ends here
