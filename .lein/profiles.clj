{:user {:plugins [[lein-environ "0.4.0"]
                  [lein-ancient "0.5.5"]
                  [jonase/eastwood "0.1.2"]
                  [lein-kibit "0.0.8"]]
        :eastwood {:add-linters [:unused-fn-args
                                 :unused-namespaces]}
        :env {:servo-conf "/Users/trevis/work/tom-servo/dev.conf"}}}
