(defpackage :sicp.sicp3-test
  (:use :cl :fiveam :sicp.sicp3)
  (:export #:run!
           #:all-tests
           #:nil))
(in-package :sicp.sicp3-test)

(def-suite sicp3-tests
  :description "Tests for chapter 3 of SICP")

(in-suite sicp3-tests)

;; delayed tests

(test memo-proc-test
  (is (= 5 (funcall (memo-proc (lambda () 5))))))

(test delay-test
  (is (functionp (delay (+ 1 2))))
  (is (= 3 (funcall (delay (+ 1 2))))))

(test force-delayed
  (is (= 12 (force (delay (* 3 4))))))

;; stream tests

(test stream-car-test
  (is (= 2 (stream-car (cons-stream 2 3)))))

(test stream-cdr-test
  (is (= 3 (stream-cdr (cons-stream 2 3)))))

(test integer-stream-test
  (is (consp (integer-stream)))
  (is (= 5 (stream-ref (integer-stream) 5))))

(test stream-filter-test
  (is (= 1 (stream-ref (stream-filter #'oddp (integer-stream)) 0)))
  (is (= 3 (stream-ref (stream-filter #'oddp (integer-stream)) 1))))

(test take-test
  (is (equalp '(0 1 2 3 4) (take 5 (integer-stream)))))

(run! 'sicp3-tests)
