;;; org-custom --- Summary
;;; Commentary:
;;; org-mode customizations

;;; Code:

(require 'use-package)

(use-package org
  :ensure t
  :bind (("C-M-<return>" . org-insert-todo-subheading))
  :config (setq org-agenda-files '("~/org/TODO.org"
				   "~/org/tasks.org"
				   "~/org/timed.org"))
  (setq org-capture-templates '(("t" "TODO" entry
                               (file "~/org/TODO.org")
                               "* TODO %i%? [/]")))
  (setq org-refile-targets '(("~/org/someday.org" :level . 1)
			     ("~/org/tasks.org" :maxlevel . 3)
			     ("~/org/timed.org" :maxlevel . 2)))
  (setq org-todo-keywords '((sequence "TODO(t)" "STARTED(s!/!)" "|" "DONE(d!/!)" "CANCELLED(c!/!)")))
  (setq org-refile-allow-creating-parent-nodes 'confirm) ;; on refile, let selected be a top level
  (setq org-refile-use-outline-path 'file) ; when refiling start with filename instead of just a header
  (setq org-outline-path-complete-in-steps nil) ; complete the outline path in one-shot so this works with helm
  (defun org-summary-todo-cookie-update (num-done num-not-done)
    "Change org state based on number done"
    (org-todo (cond ((= num-done 0)
		     "TODO")
		    ((= num-not-done 0)
		     "DONE")
		    (t
		     "STARTED"))))
  (add-hook 'org-after-todo-statistics-hook #'org-summary-todo-cookie-update)
  )

(use-package org-ac
  :ensure t)

(use-package ox-reveal
  :ensure t)

(use-package htmlize
  :ensure t)

(defun add-notes ()
  "Insert a #+BEGIN_NOTES #+END_NOTES around a region."
  (interactive)
  (let ((p1 (region-beginning))
        (p2 (region-end)))
    (goto-char p2)
    (insert "\n#+END_NOTES\n")
    (goto-char p1)
    (insert "#+BEGIN_NOTES\n")))

(define-prefix-command 'org-global-keymap)
(global-set-key (kbd "C-c o" ) 'org-global-keymap)
(define-key 'org-global-keymap (kbd "a") 'org-agenda)
(define-key 'org-global-keymap (kbd "l") 'org-store-link)
(define-key 'org-global-keymap (kbd "c") 'org-capture)
(define-key 'org-global-keymap (kbd "n") 'add-notes)

(use-package toc-org
  :ensure t
  :config
  (add-hook 'org-mode-hook 'toc-org-mode)
  (add-hook 'markdown-mode-hook 'toc-org-mode)
  (define-key markdown-mode-map (kbd "\C-c\C-o") 'toc-org-markdown-follow-thing-at-point))
