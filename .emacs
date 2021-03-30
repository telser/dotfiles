(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(eval-when-compile
  (package-refresh-contents)
  (package-install 'use-package) ; everything else will be installed/configured with use-package
  (package-install 'diminish) ; use-package can take advantage of diminish to remove minor modes fro the modeline
  (require 'use-package)
  (require 'diminish))

; base level stuff, commands/search

;; compile the child configuration files
(byte-recompile-directory (expand-file-name "~/emacs") 0)
(add-to-list 'load-path "~/emacs")
(load-library "base")
(load-library "display")
(load-library "buffer")
(desktop-save-mode 1)

;; language stuff
(use-package dhall-mode
  :ensure t)
(use-package haskell-mode
  :ensure t)
(use-package irony
  :ensure t)
(use-package lua-mode
  :ensure t)
(use-package yaml-mode
  :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(buffer-move darkokai-theme all-the-icons helm-ag workgroups2 syntax-subword smartparens command-log-mode smex diminish use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
