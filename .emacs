;;; package --- Summary
;;; emacs init is there anymore to say?

;;; Commentary:
;;; Broken up into smaller files below

;;; Code:
(add-to-list 'load-path "~/emacs")
(add-to-list 'load-path "~/emacs/prog")
(add-to-list 'load-path "~/.emacs.d/lisp")
(load-library "org-custom")
(load-library "base-custom")
(load-library "priv") ;; stuff not in version control
(load-library "clojure-custom")
(load-library "elisp-custom")
(load-library "erlang-custom")
(load-library "haskell-custom")
(load-library "js-custom")
(load-library "ruby-custom")
(load-library "rust-custom")
(load-library "web-custom")
(load-library "ercrc")
(load-library "elm-custom")
(load-library "purescript-custom")


(server-start)
(provide '.emacs)
;;; .emacs ends here
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
 '(haskell-align-imports-pad-after-name t)
 '(haskell-notify-p t)
 '(haskell-stylish-on-save t)
 '(haskell-tags-on-save t)
 '(helm-ff-auto-update-initial-value t)
 '(helm-move-to-line-cycle-in-source t)
 '(js2-highlight-level 3)
 '(mac-command-modifier (quote super))
 '(mac-option-modifier (quote meta))
 '(magit-emacsclient-executable "/usr/local/bin/emacsclient")
 '(magit-gitk-executable (quote gitk))
 '(org-agenda-files
   (quote
    ("~/org/work.org" "~/org/home.org" "~/org/personal.org")))
 '(ruby-deep-arglist nil)
 '(visible-bell nil)
 '(winner-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mouse ((t (:background "white smoke")))))
