#lang racket

(require raco/command-name
         rackunit)

(define (read-command-line)
  (define (remove-rkt string)
    (let-values ([(x filepath z) (split-path (string->path string))])
      (car (string-split (path->string filepath) ".rkt"))))
  ;(define current-num-tests (make-parameter #f))  
  (command-line
   #:program (short-program+command-name)   
   #:args (homework tests)
   (let* ([outputfile-path (string-append "grade_" (remove-rkt homework) "_with_" (remove-rkt tests) ".rkt")]
          [testing-contents (port->string (open-input-file tests))])
     ;; Create gradefile
     (begin
       (with-output-to-file (simple-form-path outputfile-path) #:mode 'text #:exists 'replace
         (lambda ()
           (begin
             (display testing-contents)
             (display (string-append "\n(require \"" homework "\")\n\n")))))
       (dynamic-require outputfile-path #f)))))

(read-command-line)
