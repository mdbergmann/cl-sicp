(defpackage :sicp.lazy
  (:use :cl)
  (:nicknames :lazy)
  (:export #:lazy-cons
           #:lazy-car
           #:lazy-cdr
           #:delay
           #:force
           #:range
           #:take
           #:lazy-filter))

(in-package :sicp.lazy)

(defmacro delay (exp)
  `(lambda () ,exp))

(defun force (delayed-object)
  (funcall delayed-object))

(defmacro lazy-cons (a b)
  `(cons ,a (delay ,b)))

(defun lazy-car (lazy-seq)
  (car lazy-seq))

(defun lazy-cdr (lazy-seq)
  (force (cdr lazy-seq)))

(defun range (&key (from 0))
  (lazy-cons
   from
   (range :from (1+ from))))

(defun lazy-filter (pred lazy-seq)
  (cond
    ((null lazy-seq)
     nil)
    ((funcall pred (lazy-car lazy-seq))
     (lazy-cons (lazy-car lazy-seq)
                (lazy-filter pred (lazy-cdr lazy-seq))))
    (t
     (lazy-filter pred (lazy-cdr lazy-seq)))))

(defun even-numbers ()
  (lazy-filter #'evenp (range)))

(defun divisable-by-7 ()
  (lazy-filter (lambda (x) (divisable-p x 7)) (range)))

(defun divisable-p (x y)
  (= (rem x y) 0))

(defun take (n lazy-seq)
  (if (= n 0)
      nil
      (cons (lazy-car lazy-seq)
            (take (1- n) (lazy-cdr lazy-seq)))))
