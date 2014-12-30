;;; Org Mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/org/work.org"
                             "~/org/personal.org"
                             "~/org/home.org"))

(setq org-tag-persistent-alist
      '((:startgroup . nil)
        ("@laptop" . nil)
        ("@desktop" . nil)
        ("@rpi" . nil)
        ("@server" . nil)
        (:endgroup . nil)
        (:startgroup . nil)
        ("improvement" . ?i)
        ("task" . ?t)
        (:endgroup . nil)
        ("c" . ?c)
        ("clj" . ?l)
        ("erl" . ?e)
        ("elm" . ?m)
        ("hs" . ?h)
        ("jl" . ?j)
        ("js" . ?s)
        ("py" . ?p)
        ("r" . ?r)
        ("rb" . ?b)
        ("rs" . ?u)
))

(org-agenda-list)
