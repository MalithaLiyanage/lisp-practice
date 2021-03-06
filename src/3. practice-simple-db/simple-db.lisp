(defvar *db*)

(defun make-user (firstName lastName age email)
  (list :firstName firstName :lastName lastName :age age :email email))

(defun add-user (user)
  (push user *db*))

(defun dump-db ()
  (dolist (user *db*)
    (format t "~{~a:~10t~a~%~}~%}" user)))

(defun prompt-read (prompt)
  (format *query-io* "~a: " prompt)
  (force-output *query-io*)
  (read-line *query-io*))

(defun prompt-for-user ()
  (make-user
   (prompt-read "firstName")
   (prompt-read "lastName")
   (or (parse-integer (prompt-read "age") :junk-allowed t) 0) ; or is used to handle nil values
   (prompt-read "email")))

(defun add-users ()
  (loop (add-user (prompt-for-user))
	(if (not (y-or-n-p "Another? [y/n]: ")) (return))))

(defun save-db (fileName)
  (with-open-file (out fileName
		       :direction :output ; file is opened to write in it
		       :if-exists :supersede) ;overwrite the file if exists
    (with-standard-io-syntax
      (print *db* out)))) ;print db to the file

(defun load-db (fileName)
  (with-open-file (in fileName); default is input therefore direction is input no need to say it
    (with-standard-io-syntax
      (setf *db* (read in)))))


(defun select-by-name (name)
  (remove-if-not
   #'(lambda (user) (equal (getf user :firstName) name))
   *db*))

(defun update (selector-fn &key firstName lastName age email)
  (setf *db*
	(mapcar
	 #'(lambda (row)
	     (when (funcall selector-fn row)
	       (if firstName (setf (getf row :firstName) firstName))
	       (if lastName (setf (getf row :lastName) lastName))
	       (if age (setf (getf row :age) age))
	       (if email (setf (getf row :email) email)))
	     row)
	 *db*)))
