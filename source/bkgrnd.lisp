(in-package :de.anvi.croatoan)

;; bkgrnd applies to every char in the window.
;; bkgrndset applies only to new chars inserted after the call to bkgdset.
;; i.e. with bkgrnd we manipulate the existing text, with bkgrndset the new text.

;; the attribute part of the background char is combined with any chars added.
;; because of that, we cant use alternate chars as background chars, since
;; :altcharset is an attribute.

(defun set-background-cchar_t (window char &optional (apply t))
  "Set a wide complex character as the background of a window.

The attribute part of the background character is combined with
simple characters added to the window.

If apply is t, the background setting is immediately applied to all cells
in the window.

Otherwise, it is applied only to newly added simple characters."
  (let ((fn (if apply #'%wbkgrnd #'%wbkgrndset))
        (count 1))
    (if char
        (funcall-make-cchar_t fn window char nil nil count)
        ;; setting char to nil means to unset the background
        ;; unset the background means set space as char and the default color pair 0
        (funcall-make-cchar_t fn window #\space nil (number-to-pair 0) count))))

;; used in: get-background-cchar_t, extract-wide-char
(defun funcall-get-cchar_t (fn window)
  "Call function fn to read a cchar_t from window and return it as a wide complex char."
  (with-foreign-object (ptr '(:struct cchar_t))
    ;; read a struct cchar_t into the space allocated with ptr
    (funcall fn (winptr window) ptr)
    ;; the slot cchar-chars is a a pointer to the wchar_t array.
    (let* ((char (mem-aref (foreign-slot-pointer ptr '(:struct cchar_t) 'cchar-chars) 'wchar_t 0))
           ;; ABI6
           (col (foreign-slot-value ptr '(:struct cchar_t) 'cchar-colors))
           (attr (foreign-slot-value ptr '(:struct cchar_t) 'cchar-attr)))
      (make-instance 'complex-char
                     :simple-char (code-char char)
                     :attributes (chtype2attrs attr)
                     ;; ABI6
                     ;;:color-pair (number->pair col)
                     ;; ABI5
                     ;; the color pair is not placed into the cchar_t slot, but ORed into the attribute int.
                     :color-pair (chtype2colors attr)))))

(defun get-background-cchar_t (window)
  "Return the wide complex char that is the background character of the window."
  (funcall-get-cchar_t #'%wgetbkgrnd window))
