(defpackage :sicp.sicp2
  (:use :cl)
  (:nicknames :sicp2)
  (:export #:mymap
           #:for-each
           #:count-leaves
           #:flatten
           #:accumulate
           #:foldl
           #:foldr
           #:flatmap))

(in-package :sicp2)

(defun mymap (fun items)
  (if (null items)
      nil
      (cons (funcall fun (car items))
            (mymap fun (cdr items)))))

(defun for-each (fun items)
  (if (null items)
      nil
      (progn
        (funcall fun (car items))
        (for-each fun (cdr items)))))

(defun count-leaves (items)
  (if (null items)
      0
      (if (not (consp items))
          1
          (+ (count-leaves (car items))
             (count-leaves (cdr items))))))

(defun flatten (lst)
  (cond
    ((null lst)
     nil)
    ((listp (car lst))
     (append (flatten (car lst)) (flatten (cdr lst))))
    (t 
     (append (list (car lst)) (flatten (cdr lst))))))

(defun accumulate (op initial items)
  "Effectively foldr"
  (reduce op items :from-end t :initial-value initial))

(defun foldl (op initial items)
  (reduce op items :initial-value initial))

(defun foldr (op initial items)
  (reduce op items :from-end t :initial-value initial))

(defun flatmap (op seq)
  (mapcar op (flatten seq)))

;; excercises

;; 2.33

(defun ac-map (op items)
  (accumulate (lambda (x acc)
                (cons (funcall op x) acc))
              nil items))

(defun ac-append (seq1 seq2)
  (accumulate #'cons seq2 seq1))

(defun ac-length (seq)
  (accumulate #'(lambda (x acc)
                  (declare (ignore x))
                  (1+ acc))
              0 seq))

;; 2.35

(defun ac-count-leaves (tree)
  (accumulate (lambda (x y)
                (if (consp x)
                    (+ (ac-count-leaves x) y)
                    (1+ y)))
              0
              tree))

(defun ac-count-leaves--map (tree)
  (accumulate #'+
              0
              (mymap (lambda (x)
                       (if (consp x)
                           (ac-count-leaves--map x)
                           1))
                     tree)))

