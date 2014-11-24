(require 'erc)

(erc :server "irc.freenode.net" :port "6667" :nick "telser"
     :full-name "telser")
(erc-tls :server "irc.lambdaphil.es" :port "9999" :nick "telser"
	:full-name "telser")

(setq erc-autojoin-channels-alist '(("freenode.net" "#clojure" "#elm" "#erlang" "#haskell" "#typed-clojure")
                                    ("lambdaphil.es" "#lambdaphiles" "#dev")))

(setq erc-prompt (lambda () (concat "[" (buffer-name) "]")))
