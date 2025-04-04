;;; package -- Summary
;;; Commentary:
;;; Code:

(require 'org)
(define-key global-map (kbd "H-RET")  'org-meta-return)
(define-key global-map "\C-H-a l" 'org-store-link)
(define-key global-map "\C-H-a a" 'org-agenda)
(global-set-key (kbd "H-a a") 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files '("~/org/TODO.org"))

;(setq org-completion-use-ido 1)

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

;; (:startgrouptag)
;;         ("SYS")
;;         (:grouptags)
;;         ("c" . ?c)
;;         ("rs" . ?u)
;;         (:endgrouptag)
;;         (:startgrouptag)
;;         ("GEN")
;;         (:grouptags)
;;         ("clj" . ?o)
;;         ("erl" . ?e)
;;         ("hs" . ?h)
;;         ("py" . ?y)
;;         ("rb" . ?b)
;;         (:endgrouptag)
;;         (:startgrouptag)
;;         ("WWW")
;;         (:grouptags)
;;         ("elm" . ?m)
;;         ("js" . ?j)
;;         ("purs" . ?p)
;;         (:endgrouptag)
;;         (:startgrouptag)
;;         ("DAT")
;;         (:grouptags)
;;         ("jl" . ?a)
;;         ("r" . ?r)
;;         (:endgrouptag)
;;         (:startgrouptag)
;;         ("OTH")
;;         (:grouptags)
;;         ("el" . ?l)
;;         ("sh" . ?s)
;;         (:endgrouptag)

;(org-agenda-list)
;;; org-custom ends here
