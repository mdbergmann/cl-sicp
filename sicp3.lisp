(defpackage :sicp.sicp3
  (:use :cl)
  (:nicknames :sicp3)
  (:export #:memo-proc
           #:delay
           #:force
           #:cons-stream
           #:stream-car
           #:stream-cdr
           #:integer-stream
           #:stream-ref
           #:stream-filter
           #:take)
  )

(in-package :sicp.sicp3)

;; delayed primitives

(defun memo-proc (proc)
  (let ((already-run-p nil)
        (result nil))
    (lambda ()
      (if already-run-p
          result
          (progn
            (setf result (funcall proc))
            (setf already-run-p t)
            result)))))

(defmacro delay (exp)
  `(memo-proc (lambda () ,exp)))

(defun force (delayed-obj)
  (funcall delayed-obj))

;; stream primitives

(defmacro cons-stream (a b)
  `(cons ,a (delay ,b)))

(defun stream-car (stream)
  (car stream))

(defun stream-cdr (stream)
  (force (cdr stream)))

;; stream generators

(defun integer-stream (&optional (from 0))
  (cons-stream
   from
   (integer-stream (1+ from))))

;; stream consumers

(defun stream-ref (stream n)
  (if (= n 0)
      (stream-car stream)
      (stream-ref
       (stream-cdr stream)
       (1- n))))

(defun stream-filter (pred stream)
  (cond
    ((null stream)
     nil)
    ((funcall pred (stream-car stream))
     (cons-stream (stream-car stream)
                  (stream-filter pred (stream-cdr stream))))
    (t
     (stream-filter pred (stream-cdr stream)))))

(defun take (n stream)
  (if (= n 0)
      nil
      (cons (stream-car stream)
            (take (1- n) (stream-cdr stream)))))
