(defpackage :sicp.sicp2-test
  (:use :cl :fiveam :sicp2)
  (:export #:run!
           #:all-tests
           #:nil))
(in-package :sicp.sicp2-test)

(def-suite sicp2-tests)
(in-suite sicp2-tests)

(test map-test
  (is (equalp nil (mymap #'identity nil)))
  (is (equalp '(1 2 3) (mymap #'identity '(1 2 3))))
  (is (equalp '(1 4 9) (mymap (lambda (x) (* x x)) '(1 2 3))))
  (is (equalp '(10 5 8) (mymap #'abs '(-10 -5 8)))))

(test for-each-test
  (for-each #'print '(1 2 3 4)))

(test count-leaves-test
  (is (= 4 (count-leaves (cons (list 1 2) (list 3 4))))))

(test flatten-test
  (is (equalp (list 1 2 3 4 5) (flatten (list 1 (list 2 3) (list 4 5))))))

(test accumulate-test
  (is (= 5 (accumulate #'+ 0 (list 1 2 2))))
  (is (equalp (list 1 2 2) (accumulate #'cons nil (list 1 2 2)))))

(test foldl-test
  (is (= 5 (foldl #'+ 0 (list 1 2 2)))))

(test foldr-test
  (is (equalp (list 1 2 2) (foldr #'cons nil (list 1 2 2)))))

(test flatmap-test
  (is (equalp (list 2 3 4 5 6) (flatmap #'1+ (list 1 (list 2 3) (list 4 5))))))

;; excercises tests

(test ac-map
  (is (equalp '(2 3 4 5 6 7) (sicp::ac-map #'1+ '(1 2 3 4 5 6)))))

(test ac-append
  (is (equalp '(1 2 3 4 5 6) (sicp::ac-append '(1 2 3) '(4 5 6)))))

(test ac-length
  (is (= 5 (sicp::ac-length '(1 2 3 4 5)))))

(test ac-count-leaves
  (is (= 4 (sicp::ac-count-leaves (cons 1 (cons 2 (cons 3 (cons 4 nil))))))))

(test ac-count-leaves--map
  (is (= 4 (sicp::ac-count-leaves--map (cons 1 (cons 2 (cons 3 (cons 4 nil))))))))

(run! 'sicp2-tests)
