(defpackage :sicp.sicp3-test
  (:use :cl :fiveam :sicp.sicp3)
  (:export #:run!
           #:all-tests
           #:nil))
(in-package :sicp.sicp3-test)

(def-suite sicp3-tests
  :description "Tests for chapter 3 of SICP")

(in-suite sicp3-tests)


(run! 'sicp3-tests)
