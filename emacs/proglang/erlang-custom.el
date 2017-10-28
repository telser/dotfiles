;;; Package --- Summary:
;;; Erlang mode

;;; Commentary:
;;; Code:

(require-packages '(erlang edts alchemist company-distel company-erlang
                           elixir-mode flycheck-dialyxir flycheck-dialyzer
                           flycheck-elixir flycheck-rebar3 flymake-elixir
                           lfe-mode))
(add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))
;;; Erlang-custom ends here
