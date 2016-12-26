#lang info

(define name "grade")
(define scribblings '(("scribblings/rackunit-grade.scrbl")))

(define raco-commands
  '(("grade"
     rackunit/raco-grade
     "Grade homework file based on RackUnit tests"
     25)))

(define test-omit-paths
  '("scribblings"))
