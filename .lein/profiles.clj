{:user {:plugins [[lein-immutant "1.1.0"]
                  [lein-environ "0.4.0"]
                  [jonase/eastwood "0.1.1"]
                  [lein-kibit "0.0.8"]]
        :eastwood {:add-linters [:unused-fn-args
                                 :unused-namespaces]}
        :env {:servo-conf "/Users/trevis/work/tom-servo/dev.conf"}}}
