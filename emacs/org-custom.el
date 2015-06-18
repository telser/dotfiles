;;; package -- Summary
;;; Commentary:
;;; Code:
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/org/work.org"
                             "~/org/personal.org"
                             "~/org/home.org"))

(setq org-completion-use-ido 1)

;; (setq org-highest-priority ?A)
;; (setq org-lowest-priority ?Z)
;; (setq org-default-priority ?C)

(setq org-priority-faces
      '((?A . "#ff2600")
        (?B . "#ff5900")
        (?C . "#ff9200")
        (?D . "#ffab00")
        (?E . "#fefb00")
        (?L . "#932092")
        (?M . "#ae30ad")
        (?N . "#ff40ff")
        (?O . "#ff27ae")
        (?P . "#ff1493")
        (?V . "#0432ff")
        (?W . "#028eff")
        (?X . "#00fcff")
        (?Y . "#00fb80")
        (?Z . "#00f900")))

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
        ("fay" . ?f)
        ("hs" . ?h)
        ("jl" . ?j)
        ("js" . ?s)
        ("py" . ?p)
        ("r" . ?r)
        ("rb" . ?b)
        ("rs" . ?u)
))

(org-agenda-list)
;;; org-custom ends here
