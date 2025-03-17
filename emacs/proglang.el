(require 'use-package)

(use-package dhall-mode
  :ensure t
  :config
  (setq dhall-format-arguments '("--ascii")))

(use-package docker-compose-mode
  :ensure t)

(use-package dockerfile-mode
  :ensure t)

(use-package gitlab-ci-mode
  :ensure t)

(use-package irony
  :ensure t)

(use-package lua-mode
  :ensure t)

(use-package sqlformat
  :ensure t
  :hook (sql-mode . sqlformat-on-save-mode)
  :init
  (setq sqlformat-command 'pgformatter
        sqlformat-args '("-s2" "-g")))

(use-package ein
  :ensure t
  )

(use-package purescript-mode
  :ensure t)
