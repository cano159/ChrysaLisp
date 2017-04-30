(defq canvas (pop argv) pen-col 0 brush-col 0 pen-width 0)
(defq fp 32 fph (bit-shl 1 (dec fp)) mint (bit-shl -1000000 fp))

(defun set-pen-col (c) (setq pen-col c))
(defun set-pen-width (w) (setq pen-width w))
(defun set-brush-col (c) (setq brush-col c))

(defun hline (x y w)
	(when (gt w 0)
		(defq w (add x w) x (dec x))
		(while (lt (setq x (inc x)) w)
			(pixel canvas brush-col x y))))

(defun fbox (x y w h)
	(defq h (add y h) y (dec y))
	(while (lt (setq y (inc y)) h)
		(hline x y w)))

(defun fpoly (p)
	(defq e (list) ys 1000000 ye -1000000)
	(reduce (lambda (p1 p2)
		(defq x1 (add (bit-shl (elem 0 p1) fp) fph) y1 (elem 1 p1)
			x2 (add (bit-shl (elem 0 p2) fp) fph) y2 (elem 1 p2))
		(cond
			((lt y1 y2)
				(setq ys (min ys y1) ye (max ye y2))
				(push e (list x1 y1 y2 (div (sub x2 x1) (sub y2 y1)))))
			((gt y1 y2)
				(setq ys (min ys y2) ye (max ye y1))
				(push e (list x2 y2 y1 (div (sub x1 x2) (sub y1 y2))))))
		p2) p (elem -2 p))
	(sort (lambda (e1 e2)
		(lt (elem 1 e1) (elem 1 e2))) e)
	(defq i 0 j 0 ys (dec ys))
	(while (ne (setq ys (inc ys)) ye)
		(each! i j nil (lambda (_)
			(if (eq ys (elem 2 _)) (elem-set 0 _ mint))) (list e))
		(while (and (ne j (length e)) (eq ys (elem 1 (elem j e))))
			(setq j (inc j)))
		(sort (lambda (e1 e2)
			(lt (elem 0 e1) (elem 0 e2))) e i j)
		(while (and (ne i (length e)) (eq (elem 0 (elem i e)) mint))
			(setq i (inc i)))
		(defq k (sub i 2))
		(while (ne (setq k (add k 2)) j)
			(defq e1 (elem k e) e2 (elem (inc k) e)
				x1 (elem 0 e1) x2 (elem 0 e2))
			(elem-set 0 e1 (add x1 (elem 3 e1)))
			(elem-set 0 e2 (add x2 (elem 3 e2)))
			(setq x1 (bit-asr x1 fp) x2 (bit-asr x2 fp))
			(hline x1 ys (sub x2 x1)))))

(set-brush-col 0)
(fbox 0 0 512 512)

(set-brush-col 0xff0000ff)
(fpoly '((0 0) (128 512) (256 0) (384 512) (512 0) (16 512)))

(pixel canvas)
