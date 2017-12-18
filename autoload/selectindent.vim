function! selectindent#get_current_indent()
	let cur_pos = line(".")
	let total_lines = line("$")

	let current_line = cur_pos
	while (current_line <= total_lines)
		if getline(current_line) !~# '^\s*$'
			return current_line
		endif
		let current_line += 1
	endwhile

	let current_line = cur_pos
	while (current_line > 0)
		if getline(current_line) !~# '^\s*$'
			return current_line
		endif
		let current_line -= 1
	endwhile
	" We only have whitespace in our file
	return cur_pos
endfunction

function! selectindent#select_outer_indent()
	let cur_pos = line(".")
	let current_line = cur_pos
	let indent = indent(selectindent#get_current_indent())
	" Move from current indent downwards
	while (current_line < line("$") && (indent(current_line) >= indent || getline(current_line) =~# '^\s*$'))
		let current_line += 1
	endwhile
	" Store current location in jumplist. This is nice if the user
	" accidentally called this function
	execute "normal! " . cur_pos . "G"
	call cursor(current_line, 0)
	" Begin visual selection from `current_line`
	normal! V

	let current_line = cur_pos
	" Move from current indent upwards
	while (current_line > 1 && (indent(current_line) >= indent || getline(current_line) =~# '^\s*$'))
		let current_line -= 1
	endwhile
	call cursor(current_line, 0)
endfunction

function! selectindent#select_inner_indent()
	let cur_pos = line(".")
	" The line at which the indent is measured. This is not necessarily
	" the line the cursor is at, because the cursor might be on whitespace
	let indent_line = selectindent#get_current_indent()
	let indent = indent(indent_line)
	let current_line = indent_line
	let selection_start = indent_line
	let selection_end = indent_line
	" Move from current indent downwards
	while (current_line < line("$"))
		let current_line += 1
		if getline(current_line) !~# '^\s*$'
			if (indent(current_line) < indent)
				break
			endif
			let selection_end = current_line
		endif
	endwhile
	" Store current location in jumplist. This is nice if the user
	" accidentally called this function
	execute "normal! " . cur_pos . "G"
	call cursor(selection_end, 0)
	" Begin visual selection from `selection_end`
	normal! V
	let current_line = indent_line
	while (current_line > 1)
		let current_line -= 1
		if getline(current_line) !~# '^\s*$'
			if (indent(current_line) < indent)
				break
			endif
			let selection_start = current_line
		endif
	endwhile
	" Start visual selection from here
	call cursor(selection_start, 0)
endfunction
