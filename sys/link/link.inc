(import 'sys/class.inc)
(import 'sys/code.inc)
(import 'sys/list/list.inc)
(import 'sys/mail/mail.inc)

(def-class 'sys_link)
(def-method 'statics 'sys/link/statics)
(def-method 'init 'sys/link/init)
(def-method 'link 'sys/link/link)

;;;;;;;;;;;;;;;;;
; link structures
;;;;;;;;;;;;;;;;;

(def-enum 'lk_chan_status)
	(enum 'ready 'busy)
(def-enum-end)

(def-struct 'lk_table)
	(ptr 'array)
	(ulong 'array_size)
(def-struct-end)

(def-struct 'lk_node 'ln_node)
	(struct 'table 'lk_table)
	(ptr 'params)
	(ulong 'handle)
	(uint 'cpu_id)
	(uint 'task_count)
(def-struct-end)

(def-struct 'lk_statics)
	(struct 'links_list 'lh_list)
(def-struct-end)

(def-struct 'lk_msg)
	(uint 'status)
	(local-align)
	(struct 'buf (sub msg_size ln_node_size))
(def-struct-end)

(def-struct 'lk_chan)
	(uint 'task_count)
	(local-align)
	(struct 'msg0 'lk_msg)
	(struct 'msg1 'lk_msg)
	(struct 'msg2 'lk_msg)
	(struct 'msg3 'lk_msg)
	(struct 'msg4 'lk_msg)
	(struct 'msg5 'lk_msg)
(def-struct-end)

(def-struct 'lk_buffer)
	(struct 'chan_1 'lk_chan)
	(struct 'chan_2 'lk_chan)
(def-struct-end)

(def-struct 'lk_route)
	(uint 'hops)
(def-struct-end)
