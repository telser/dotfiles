;;; Org Mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/org/work.org"
                             "~/org/personal.org"
                             "~/org/home.org"))

(setq org-tag-persistent-alist
      '(("learn" . ?l) ("read" . ?a) ("task" . ?t)))
