;;; buffer -- Sumary settings and keys for buffer management

;;; Commentary:
;;; This is for everything to do with buffer management and manipulation

;;; Code:

;; winner allows for undo/redo of window operations with C-c <left> and C-c <right>
(winner-mode 1)

;; ibuffer is good at managing buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; window jump gives nicer window movement functions
(use-package window-jump
  :ensure t
  :init (define-prefix-command 'window-jump-keymap)
  :bind
  (("C-c w" . window-jump-keymap)
   ("H-w" . window-jump-keymap)
   :map window-jump-keymap
   ("d" . window-jump-down)
   ("l" . window-jump-left)
   ("r" . window-jump-right)
   ("u" . window-jump-up)
   ))

;; buffer-move gives nice functions for moving which buffer is open in which window
(use-package buffer-move
  :ensure t)

(provide 'buffer)
