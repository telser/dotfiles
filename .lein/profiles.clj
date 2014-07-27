{:user
 {:plugins [[lein-environ "0.4.0"]
            [lein-depgraph "0.1.0"]
            [lein-ancient "0.5.5"]
            [jonase/eastwood "0.1.2"]
            [lein-kibit "0.0.8"]
            [cider/cider-nrepl "0.7.0-SNAPSHOT"]]
  :eastwood {:add-linters [:unused-fn-args :unused-namespaces]}
  :env {:servo-conf "/Users/trevis/work/tom-servo/dev.conf"}
  :deploy-repositories
  [["cs-deploy" {:url "http://repo.clickscape.com:8080/repository/internal"
                 :creds :gpg}]]
  :signing {:gpg-key "05F346DB"}}}
