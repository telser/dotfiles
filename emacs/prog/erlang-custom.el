;;; Erlang


;;; Code:

(require-packages '(erlang edts))
(add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))
;;; Erlang-custom ends here