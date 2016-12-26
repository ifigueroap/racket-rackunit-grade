#lang racket

(require rackunit)

(provide evaluate-exercise)         

(define (count-failures test)
  (fold-test-results
   (lambda (result seed)
     (if (test-failure? result)
         (cons (add1 (car seed)) (add1 (cdr seed)))
         (cons (car seed) (add1 (cdr seed)))))
   (cons 0 0)
   test))
 
(define (evaluate-exercise test-suite result-handler)
  (let* ([results (count-failures test-suite)]
         [failures (car results)]
         [numtests (cdr results)]
         [suite-name (rackunit-test-suite-name test-suite)])
    (result-handler results failures numtests suite-name)))