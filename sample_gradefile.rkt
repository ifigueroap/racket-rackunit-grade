#lang racket

(require rackunit)
(require rackunit/grade)

(define-test-suite tests-my-power
  (check-equal? (my-power 10 2) (expt 10 2))
  (check-equal? (my-power 13 56) (expt 13 56)))

(define (my-result-handler results failures numtests suite-name)
  (printf "~a got ~a failures out of ~a tests" suite-name failures numtests))

(evaluate-exercise tests-my-power my-result-handler)
