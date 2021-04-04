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
  :init (define-prefix-command 'window-keymap)
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
   ("d" . delete-window)))

;; buffer-move gives nice functions for moving which buffer is open in which window
(use-package buffer-move
  :ensure t
  :init (define-prefix-command 'buffer-keymap)
  :bind (("C-c b" . buffer-keymap)
	 ("H-b" . buffer-keymap)
	 :map buffer-keymap
	 ("<down>" . buf-move-down)
	 ("<left>" . buf-move-left)
	 ("<right>" . buf-move-right)
	 ("<up>" . buf-move-up)))

(provide 'buffer)
