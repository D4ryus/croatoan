(in-package :de.anvi.croatoan)

(defun get-char (window &key y x)
  "Read in a C char (single byte) from the keyboard and return it.

If the destination coordinates y (row) and x (column) are given, move
the cursor to the destination first and then read a single byte.

The window from which the char is read is automatically refreshed."
  (let ((winptr (winptr window)))
    (cond ((and y x)
           (%mvwgetch winptr y x))
          (t
           (%wgetch winptr)))))

;; takes a simple C chtype and puts it back into the read buffer.
;; it will be read with the next get-char.
(defun unget-char (chtype)
  (%ungetch chtype))

;; takes an C int denoting a key. returns t or nil.
;; checks whether a function key is supported by the current terminal.
(defun key-supported-p (key-char)
  (%has-key key-char))

;;; NOTES

;; All those return a simple C char (or int), not a rendered chtype (unsigned long int).
;; you can use code-char to convert this simple char/int to a lisp char.
;; but you cannot use this to convert a chtype to a lisp char.

;;; TODOs

;; [ ] Escape sequences. They are neither function keys nor chars.



;; keys above the first 0-255 chars. cannot fit in a char variable any more.
;; http://tldp.org/HOWTO/NCURSES-Programming-HOWTO/keys.html
(defparameter *key-alist*
  '((:code_yes  . 256) 
    (:min       . 257) 
    (:break     . 257) 
    (:down      . 258) 
    (:up        . 259)
    (:left      . 260) 
    (:right     . 261) 
    (:home      . 262) 
    (:backspace . 263) 
    (:f0        . 264)

    (:f1        . 265)
    (:f2        . 266)
    (:f3        . 267)
    (:f4        . 268)
    (:f5        . 269)
    (:f6        . 270)
    (:f7        . 271)
    (:f8        . 272)
    (:f9        . 273)
    (:f10       . 274)
    (:f11       . 275)
    (:f12       . 276)
    (:f13       . 277)
    (:f14       . 278)
    (:f15       . 279)
    (:f16       . 280)
    (:f17       . 281)
    (:f18       . 282)
    (:f19       . 283)
    (:f20       . 284)
    (:f21       . 285)
    (:f22       . 286)
    (:f23       . 287)
    (:f24       . 288)
    (:f25       . 289)
    (:f26       . 290)
    (:f27       . 291)
    (:f28       . 292)
    (:f29       . 293)
    (:f30       . 294)
    (:f31       . 295)
    (:f32       . 296)
    (:f33       . 297)
    (:f34       . 298)
    (:f35       . 299)
    (:f36       . 300)
    (:f37       . 301)
    (:f38       . 302)
    (:f39       . 303)
    (:f40       . 304)
    (:f41       . 305)
    (:f42       . 306)
    (:f43       . 307)
    (:f44       . 308)
    (:f45       . 309)
    (:f46       . 310)
    (:f47       . 311)
    (:f48       . 312)
    (:f49       . 313)
    (:f50       . 314)
    (:f51       . 315)
    (:f52       . 316)
    (:f53       . 317)
    (:f54       . 318)
    (:f55       . 319)
    (:f56       . 320)
    (:f57       . 321)
    (:f58       . 322)
    (:f59       . 323)
    (:f60       . 324)
    (:f61       . 325)
    (:f62       . 326)
    (:f63       . 327)

    (:dl        . 328) 
    (:il        . 329) 
    (:dc        . 330)
    (:ic        . 331) 
    (:eic       . 332) 
    (:clear     . 333) 
    (:eos       . 334) 
    (:eol       . 335) 
    (:sf        . 336)
    (:sr        . 337) 
    (:npage     . 338) 
    (:ppage     . 339) 
    (:stab      . 340) 
    (:ctab      . 341)
    (:catab     . 342) 
    (:enter     . 343) 
    (:sreset    . 344) 
    (:reset     . 345) 
    (:print     . 346)
    (:ll        . 347) 
    (:a1        . 348) 
    (:a3        . 349) 
    (:b2        . 350) 
    (:c1        . 351) 
    (:c3        . 352)
    (:btab      . 353) 
    (:beg       . 354) 
    (:cancel    . 355) 
    (:close     . 356) 
    (:command   . 357)
    (:copy      . 358) 
    (:create    . 359) 
    (:end       . 360) 
    (:exit      . 361) 
    (:find      . 362)
    (:help      . 363) 
    (:mark      . 364) 
    (:message   . 365) 
    (:move      . 366) 
    (:next      . 367)
    (:open      . 368) 
    (:options   . 369) 
    (:previous  . 370) 
    (:redo      . 371)
    (:reference . 372) 
    (:refresh   . 373) 
    (:replace   . 374) 
    (:restart   . 375)
    (:resume    . 376) 
    (:save      . 377) 
    (:sbeg      . 378) 
    (:scancel   . 379) 
    (:scommand  . 380)
    (:scopy     . 381) 
    (:screate   . 382) 
    (:sdc       . 383) 
    (:sdl       . 384) 
    (:select    . 385)
    (:send      . 386) 
    (:seol      . 387) 
    (:sexit     . 388) 
    (:sfind     . 389) 
    (:shelp     . 390)
    (:shome     . 391) 
    (:sic       . 392) 
    (:sleft     . 393) 
    (:smessage  . 394) 
    (:smove     . 395)
    (:snext     . 396) 
    (:soptions  . 397) 
    (:sprevious . 398) 
    (:sprint    . 399)
    (:sredo     . 400) 
    (:sreplace  . 401) 
    (:sright    . 402) 
    (:srsume    . 403)
    (:ssave     . 404) 
    (:ssuspend  . 405) 
    (:sundo     . 406) 
    (:suspend   . 407) 
    (:undo      . 408)
    (:mouse     . 409) 
    (:resize    . 410) 
    (:event     . 411) 
    (:max       . 511)))

;; Takes a short int returned by get-char, 
;; returns a keyword represeting the function key.
;; returns nil if number is not in the list.
(defun function-key (number)
  (car (rassoc number *key-alist*)))

;; Returns t if the number is a key, nil if it is a char.
(defun function-key-p (number)
  (if (and (> number 255)
           (rassoc number *key-alist*))
      t
      nil))

;; http://rosettacode.org/wiki/Keyboard_input/Keypress_check
;; Returns t if a key has been pressed and a char can be read by get-char.
;; Requires input-blocking for window to be set to nil.
(defun key-pressed-p (window)
  (let ((ch (get-char window)))
    ;; ncurses get-char returns -1 when no key was pressed.
    (unless (= ch -1)
      ;; if a key was pressed, put it back into the input buffer so it can be rad by the next call to get-char.
      (unget-char ch)
      ;; Return t.
      t)))

;; works only when input-blocking is set to nil. enable-fkeys should also be t.
;; events can be handled with case.
;; events can be nil (no key pressed), characters #\a and function keys like :up, :down, etc.
;; todo: mouse, resizekey
(defun get-event (window)
  (let ((ch (get-char window)))
    (cond
      ;; -1 means no key has been pressed.
      ((= ch -1) nil) 
      ;; 0-255 are regular chars, whch can be converted to lisp chars with code-char.
      ((and (>= ch 0) (<= ch 255)) (code-char ch))
      ;; if the code belongs to a known function key, return a keyword symbol.
      ((function-key-p ch)
       (let ((ev (function-key ch)))
         (if (eq ev :mouse)
             (multiple-value-bind (mev y x) (get-mouse-event)
               (values mev y x)) ; returns 3 values, see mouse.lisp
             ev)))
      ;; todo: unknown codes, like mose, resize and unknown function keys.
      (t (error "invalid value of char received from ncurses.")))))

#|
    ;; we dont need them defined as octal literals, this is antique.
  '((:code_yes  . #o400)
    (:min       . #o401)
    (:break     . #o401)
    (:down      . #o402)
    (:up        . #o403)
    (:left      . #o404)
    (:right     . #o405)
    (:home      . #o406)
    (:backspace . #o407)
    (:f0        . #o410)

    ;; how to handle this???
    ;; F(n)        (KEY_F0+(n))    /* Value of function key n */
    ;; (loop for i from 1 to 63 do (format t "(:f~A . ~A)~%" i (+ F0 i)))

    (:dl        . #o510)
    (:il        . #o511)
    (:dc        . #o512)
    (:ic        . #o513)
    (:eic       . #o514)
    (:clear     . #o515)
    (:eos       . #o516)
    (:eol       . #o517)
    (:sf        . #o520)
    (:sr        . #o521)
    (:npage     . #o522)
    (:ppage     . #o523)
    (:stab      . #o524)
    (:ctab      . #o525)
    (:catab     . #o526)
    (:enter     . #o527)
    (:sreset    . #o530)
    (:reset     . #o531)
    (:print     . #o532)
    (:ll        . #o533)
    (:a1        . #o534)
    (:a3        . #o535)
    (:b2        . #o536)
    (:c1        . #o537)
    (:c3        . #o540)
    (:btab      . #o541)
    (:beg       . #o542)
    (:cancel    . #o543)
    (:close     . #o544)
    (:command   . #o545)
    (:copy      . #o546)
    (:create    . #o547)
    (:end       . #o550)
    (:exit      . #o551)
    (:find      . #o552)
    (:help      . #o553)
    (:mark      . #o554)
    (:message   . #o555)
    (:move      . #o556)
    (:next      . #o557)
    (:open      . #o560)
    (:options   . #o561)
    (:previous  . #o562)
    (:redo      . #o563)
    (:reference . #o564)
    (:refresh   . #o565)
    (:replace   . #o566)
    (:restart   . #o567)
    (:resume    . #o570)
    (:save      . #o571)
    (:sbeg      . #o572)
    (:scancel   . #o573)
    (:scommand  . #o574)
    (:scopy     . #o575)
    (:screate   . #o576)
    (:sdc       . #o577)
    (:sdl       . #o600)
    (:select    . #o601)
    (:send      . #o602)
    (:seol      . #o603)
    (:sexit     . #o604)
    (:sfind     . #o605)
    (:shelp     . #o606)
    (:shome     . #o607)
    (:sic       . #o610)
    (:sleft     . #o611)
    (:smessage  . #o612)
    (:smove     . #o613)
    (:snext     . #o614)
    (:soptions  . #o615)
    (:sprevious . #o616)
    (:sprint    . #o617)
    (:sredo     . #o620)
    (:sreplace  . #o621)
    (:sright    . #o622)
    (:srsume    . #o623)
    (:ssave     . #o624)
    (:ssuspend  . #o625)
    (:sundo     . #o626)
    (:suspend   . #o627)
    (:undo      . #o630)
    (:mouse     . #o631)
    (:resize    . #o632)
    (:event     . #o633)
    (:max       . #o777)))

#define KEY_CODE_YES    0400            /* A wchar_t contains a key code */
#define KEY_MIN         0401            /* Minimum curses key */
#define KEY_BREAK       0401            /* Break key (unreliable) */
#define KEY_DOWN        0402            /* down-arrow key */
#define KEY_UP          0403            /* up-arrow key */
#define KEY_LEFT        0404            /* left-arrow key */
#define KEY_RIGHT       0405            /* right-arrow key */
#define KEY_HOME        0406            /* home key */
#define KEY_BACKSPACE   0407            /* backspace key */
#define KEY_F0          0410            /* Function keys.  Space for 64 */
#define KEY_F(n)        (KEY_F0+(n))    /* Value of function key n */
#define KEY_DL          0510            /* delete-line key */
#define KEY_IL          0511            /* insert-line key */
#define KEY_DC          0512            /* delete-character key */
#define KEY_IC          0513            /* insert-character key */
#define KEY_EIC         0514            /* sent by rmir or smir in insert mode */
#define KEY_CLEAR       0515            /* clear-screen or erase key */
#define KEY_EOS         0516            /* clear-to-end-of-screen key */
#define KEY_EOL         0517            /* clear-to-end-of-line key */
#define KEY_SF          0520            /* scroll-forward key */
#define KEY_SR          0521            /* scroll-backward key */
#define KEY_NPAGE       0522            /* next-page key */
#define KEY_PPAGE       0523            /* previous-page key */
#define KEY_STAB        0524            /* set-tab key */
#define KEY_CTAB        0525            /* clear-tab key */
#define KEY_CATAB       0526            /* clear-all-tabs key */
#define KEY_ENTER       0527            /* enter/send key */
#define KEY_SRESET      0530            /* Soft (partial) reset (unreliable) */
#define KEY_RESET       0531            /* Reset or hard reset (unreliable) */
#define KEY_PRINT       0532            /* print key */
#define KEY_LL          0533            /* lower-left key (home down) */
#define KEY_A1          0534            /* upper left of keypad */
#define KEY_A3          0535            /* upper right of keypad */
#define KEY_B2          0536            /* center of keypad */
#define KEY_C1          0537            /* lower left of keypad */
#define KEY_C3          0540            /* lower right of keypad */
#define KEY_BTAB        0541            /* back-tab key */
#define KEY_BEG         0542            /* begin key */
#define KEY_CANCEL      0543            /* cancel key */
#define KEY_CLOSE       0544            /* close key */
#define KEY_COMMAND     0545            /* command key */
#define KEY_COPY        0546            /* copy key */
#define KEY_CREATE      0547            /* create key */
#define KEY_END         0550            /* end key */
#define KEY_EXIT        0551            /* exit key */
#define KEY_FIND        0552            /* find key */
#define KEY_HELP        0553            /* help key */
#define KEY_MARK        0554            /* mark key */
#define KEY_MESSAGE     0555            /* message key */
#define KEY_MOVE        0556            /* move key */
#define KEY_NEXT        0557            /* next key */
#define KEY_OPEN        0560            /* open key */
#define KEY_OPTIONS     0561            /* options key */
#define KEY_PREVIOUS    0562            /* previous key */
#define KEY_REDO        0563            /* redo key */
#define KEY_REFERENCE   0564            /* reference key */
#define KEY_REFRESH     0565            /* refresh key */
#define KEY_REPLACE     0566            /* replace key */
#define KEY_RESTART     0567            /* restart key */
#define KEY_RESUME      0570            /* resume key */
#define KEY_SAVE        0571            /* save key */
#define KEY_SBEG        0572            /* shifted begin key */
#define KEY_SCANCEL     0573            /* shifted cancel key */
#define KEY_SCOMMAND    0574            /* shifted command key */
#define KEY_SCOPY       0575            /* shifted copy key */
#define KEY_SCREATE     0576            /* shifted create key */
#define KEY_SDC         0577            /* shifted delete-character key */
#define KEY_SDL         0600            /* shifted delete-line key */
#define KEY_SELECT      0601            /* select key */
#define KEY_SEND        0602            /* shifted end key */
#define KEY_SEOL        0603            /* shifted clear-to-end-of-line key */
#define KEY_SEXIT       0604            /* shifted exit key */
#define KEY_SFIND       0605            /* shifted find key */
#define KEY_SHELP       0606            /* shifted help key */
#define KEY_SHOME       0607            /* shifted home key */
#define KEY_SIC         0610            /* shifted insert-character key */
#define KEY_SLEFT       0611            /* shifted left-arrow key */
#define KEY_SMESSAGE    0612            /* shifted message key */
#define KEY_SMOVE       0613            /* shifted move key */
#define KEY_SNEXT       0614            /* shifted next key */
#define KEY_SOPTIONS    0615            /* shifted options key */
#define KEY_SPREVIOUS   0616            /* shifted previous key */
#define KEY_SPRINT      0617            /* shifted print key */
#define KEY_SREDO       0620            /* shifted redo key */
#define KEY_SREPLACE    0621            /* shifted replace key */
#define KEY_SRIGHT      0622            /* shifted right-arrow key */
#define KEY_SRSUME      0623            /* shifted resume key */
#define KEY_SSAVE       0624            /* shifted save key */
#define KEY_SSUSPEND    0625            /* shifted suspend key */
#define KEY_SUNDO       0626            /* shifted undo key */
#define KEY_SUSPEND     0627            /* suspend key */
#define KEY_UNDO        0630            /* undo key */
#define KEY_MOUSE       0631            /* Mouse event has occurred */
#define KEY_RESIZE      0632            /* Terminal resize event */
#define KEY_EVENT       0633            /* We were interrupted by an event */
#define KEY_MAX         0777            /* Maximum key value is 0633 */

|# 
