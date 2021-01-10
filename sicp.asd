(defsystem "sicp"
  :version "0.0.1"
  :author "Manfred Bergmann"
  :license "MIT"
  :description "SICP coding"
  :depends-on ("fiveam")
  :components ((:file "sicp")
               (:file "sicp3")
               )
  :in-order-to ((test-op (test-op "sicp/tests"))))

(defsystem "sicp/tests"
  :author "Manfred Bergmann"
  :license "MIT"
  :depends-on ("fiveam")
  :components ((:file "sicp-test")
               (:file "sicp3-test")
               )
  :description "Test system for sicp"
  :perform (test-op (op c) (symbol-call :fiveam :run!
                                        (uiop:find-symbol* '#:sicp-tests
                                                           '#:sicp-test))))
