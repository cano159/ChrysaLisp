%include 'inc/func.inc'
%include 'inc/load.inc'
%include 'class/class_string.inc'
%include 'class/class_stream.inc'
%include 'class/class_lisp.inc'

def_func class/lisp/repl_read_str
	;inputs
	;r0 = lisp object
	;r1 = stream
	;r2 = next char
	;outputs
	;r0 = lisp object
	;r1 = string
	;r2 = next char

	const char_double_quote, '"'

	ptr this, stream, string
	pubyte reloc, buffer
	ulong char

	push_scope
	retire {r0, r1, r2}, {this, stream, char}

	func_path sys_load, statics
	assign {@_function_.ld_statics_reloc_buffer}, {reloc}
	assign {reloc}, {buffer}

	func_call stream, read_char, {stream}, {char}
	loop_while {char != -1 && char != char_double_quote}
		assign {char}, {*buffer}
		assign {buffer + 1}, {buffer}
		func_call stream, read_char, {stream}, {char}
	loop_end
	func_call stream, read_char, {stream}, {char}

	func_call string, create_from_buffer, {reloc, buffer - reloc}, {string}

	eval {this, string, char}, {r0, r1, r2}
	pop_scope
	return

def_func_end