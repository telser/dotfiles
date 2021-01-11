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
  :ensure t)

;; buffer-move gives nice functions for moving which buffer is open in which window
(use-package buffer-move
  :ensure t)

(provide 'buffer)

