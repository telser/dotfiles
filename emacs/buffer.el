;;; buffer -- Sumary settings and keys for buffer management

;;; Commentary:
;;; This is for everything to do with buffer management and manipulation

;;; Code:

(require 'use-package)

;; winner allows for undo/redo of window operations with C-c <left> and C-c <right>
(winner-mode 1)

;; ibuffer is good at managing buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)

(use-package windresize
  :ensure t
  :demand)

(use-package window-number
  :ensure t
  :demand
  :config
  (window-number-mode 1)
  (defun window-select-1 ()
    (interactive)
    (window-number-select 1))
  (defun window-select-2 ()
    (interactive)
    (window-number-select 2))
  (defun window-select-3 ()
    (interactive)
    (window-number-select 3))
  (defun window-select-4 ()
    (interactive)
    (window-number-select 4))
  (defun window-select-5 ()
    (interactive)
    (window-number-select 5))
  (defun window-select-6 ()
    (interactive)
    (window-number-select 6))
  (defun window-select-7 ()
    (interactive)
    (window-number-select 7))
  (defun window-select-8 ()
    (interactive)
    (window-number-select 8))
  (defun window-select-9 ()
    (interactive)
    (window-number-select 9)))

(use-package zoom-window
  :ensure t)

;; window jump gives nicer window movement functions
(use-package window-jump
  :ensure t
  :init (define-prefix-command 'window-keymap)
  :demand
  :bind
  (("C-c w" . window-keymap)
   ("H-w" . window-keymap)
   :map window-keymap
   ("n" . window-jump-down)
   ("l" . window-jump-left)
   ("r" . window-jump-right)
   ("p" . window-jump-up)
   ("v" . split-window-vertically)
   ("h" . split-window-horizontally)
   ("d" . delete-window)
   ("<left>" . winner-undo)
   ("<right>" . winner-redo)
   ("z" . zoom-window-zoom) ;; note this comes from the zoom-window package above
   ("C-l" . clm/toggle-command-log-buffer) ;; note this comes from the command-log package
   ;; note the following actually comes from windresize package above
   ("C-r" . windresize)
   ;;
   ("M-1" . window-select-1)
   ("M-2" . window-select-2)
   ("M-3" . window-select-3)
   ("M-4" . window-select-4)
   ("M-5" . window-select-5)
   ("M-6" . window-select-6)
   ("M-7" . window-select-7)
   ("M-8" . window-select-8)
   ("M-9" . window-select-9)
   ))

;; buffer-move gives nice functions for moving which buffer is open in which window
(use-package buffer-move
  :ensure t
  :init (define-prefix-command 'buffer-keymap)
  :demand
  :bind (("C-c b" . buffer-keymap)
	 ("H-b" . buffer-keymap)
	 :map buffer-keymap
	 ("<down>" . buf-move-down)
	 ("<left>" . buf-move-left)
	 ("<right>" . buf-move-right)
	 ("<up>" . buf-move-up)))

; perspectives are nice for workload management
(use-package perspective
  :ensure t
;  :bind-keymap (("C-c C-w" . persp-mode-map))
  :init
  (setq persp-mode-prefix-key (kbd "C-c C-w"))
  :config
  (persp-mode 1))

(provide 'buffer)
;;; buffer.el ends here
