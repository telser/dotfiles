;;; configurations for json, xml, and yaml modes

(require 'use-package)

(use-package nginx-mode
  :ensure t
  :commands nginx-mode)

(use-package xkb-mode
  :ensure t)

(use-package jq-format
  :ensure t
  :config (jq-format-json-on-save-mode))

(use-package json-mode
  :ensure t
  )

(use-package yaml-mode
  :ensure t)

(use-package xml-format
  :ensure t
  :config (xml-format-on-save-mode))
(use-package xml+
  :ensure t)

(use-package graphql
  :ensure t)

(use-package graphql-doc
  :ensure t)

(use-package graphql-mode
  :ensure t)
