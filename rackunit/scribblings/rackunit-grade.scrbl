#lang scribble/manual

@(require scribble/eval
          (for-label racket rackunit/grade))

@(define qc-eval (make-base-eval))
@(qc-eval '(require racket/list
		    rackunit/grade))

@title{RackUnit Grade}

@author["Ismael Figueroa"]

This manual provides documentation for a simple Racket package for locally
grading homework using RackUnit tests and a new @exec{raco grade}
command.

@defmodule[rackunit/grade]

@section{RackUnit Grade}

@subsection{Installation}

If you have not installed the package yet, run the following command from
the command-line:

  @commandline{raco pkg install rackunit-grade}

Note that this package will require Racket v6.0 or newer to install.

Alternatively, you may use the GUI package manager from DrRacket to install
the package.

@subsection{Creating a Grading File}

To use RackUnit Grade, you first write a grading file, containing all required
libraries, and all the tests you want to run. It is recommended to define an
individual test-suite for each specific exercise in your homework. For example, let us consider the @racket[tests.rkt]
file, which defines tests for the @racket[my-power] function:

@racketblock[
(require rackunit)
(require rackunit/grade)

(define-test-suite tests-my-power
  (check-equal? (my-power 10 2) (expt 10 2))
  (check-equal? (my-power 13 56) (expt 13 56)))

(define (my-result-handler results failures numtests suite-name)
  (printf "~a got ~a failures out of ~a tests" suite-name failures numtests))

(evaluate-exercise tests-my-power my-result-handler)
]

In this case, we are evaluating function @racket[my-power], by testing it
against the reference implementation @racket[expt]. After defining the tests,
we need to call @racket[evaluate-exercise].

@defproc[(evaluate-exercise [exercise-test test-suite?][result-handler
procedure??]) void]{ Evaluates the given @racket[exercise-test-suite] and
summarizes the results using @racket[result-handler]. @racket[result-handler] takes the following arguments:

@itemlist[
  @item{results: the results object as used in @racket[fold-test-results].}
  @item{failures: the number of tests that failed.}
  @item{numtests: the total number of tests.}
  @item{suite-name: the name of the test-suite.}
]
}

@section{Grading Student Files}

Now let us consider the @racket[homework.rkt] file, which contains the solution from a student:

@racketblock[
(provide my-power)
(define (my-power base power) 0)
]

Clearly this definition is wrong. Now, to combine the grading file with the student solution
we need to use the new raco command @exec{raco grade}:

@commandline{raco grade homework.rkt tests.rkt}

This command will generate a new file @exec{grade_homework_tests.rkt} in the
current directory, which is a simple copy of @racket[tests.rkt] appended with a
@racket[(require "homework.rkt")] form. Also the new file is run, using
@racket[dynamic-require]. In order for this schema to work, it is required that
student files @racket[provide] all functions that are going to be graded.
