;;; Comment

;; Comment					; Comment

#||
multi line comment
||#

;; Just printing to std output 
(format t "Hello world ~%")

;;Prompting to enter name and displaying it using global var and a function
(print "What is your name")
(defvar *NAME* (read))
(defun hello-you (*name*)
  (format t "Hello ~a! ~%" *name*))
(setq *print-case* :capitalize) ;:upcase :downcase
(hello-you *name*)
;;; ~a : Shows the value
;;; ~s : Shows quotes around the value
;;; ~10a : Adds 10 spaces for the value with extra space to the right
;;; ~10@a : Adds 10 spaces for the value with extra space to the left

;; Defining and changing vars
(defvar *number* 0)
(setf *number* 6)
;; Also let can be used to define vars

;; Printing numbers
(format t "Number with commas: ~:d ~%" 10000000)
(format t "PI to 5 chars ~5f ~%" 3.1415934)
(format t "PI to 4 decimals ~,4f ~%" 3/141593)
(format t "10 Percent ~,,2f ~%" .10)
(format t "10 Dollars ~$ ~% ~%" 10)
