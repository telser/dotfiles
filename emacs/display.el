;;; display -- Sumary
;;; My setup for emacs display settings.

;;; Commentary:
;;; This includes theme, modeline, toolbar, font and more settings.

;;; Code:

(use-package darkokai-theme
  :ensure t
  :config
  (load-theme 'darkokai t))

(use-package all-the-icons
  :ensure t)

; get rid of the menu-bar
(menu-bar-mode -1)

; get rid of the tool-bar
(tool-bar-mode -1)

; line numbers on the left
(global-linum-mode 1)

; hide line numbers from the modeline since it is on the left
(line-number-mode -1)

; put column numbers in the modeline
(column-number-mode 1)

; turn on syntax highlighting globally
(global-font-lock-mode)

; always show matching parens
(show-paren-mode 1)

; show filesize in modeline
(size-indication-mode 1)

; set the font to Hack
(set-face-attribute 'default nil :family "Hack")

; rainbow delimiters/identifiers to make things pretty
(use-package rainbow-mode
  :ensure t
  :diminish
  :hook (prog-mode . rainbow-mode))
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))
(use-package rainbow-identifiers
  :ensure t
  :hook (prog-mode . rainbow-identifiers-mode))

; fic mode will colorize/italic TODO/FIXME and so on
(use-package fic-mode
  :ensure t
; note this is only turned on for programming modes so stuff like org does look wonky
  :hook (prog-mode . fic-mode))

(use-package workgroups2
  :ensure t
  :diminish
  :config
  (workgroups-mode 1))

(provide 'display)
