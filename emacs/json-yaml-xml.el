;;; configurations for json, xml, and yaml modes

(require 'use-package)

(use-package jq-format
  :ensure t
  :config (jq-format-json-on-save-mode))

(use-package yaml-mode
  :ensure t)

(use-package xml-format
  :ensure t
  :config (xml-format-on-save-mode))
(use-package xml+
  :ensure t)
