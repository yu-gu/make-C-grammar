% Grammar:
define program
	[c_function]
end define

define c_function
	[function_head] [NL]
	{ [NL][IN] 
	  [function_body]
	}
end define

define function_head
	[return_type] [function_name]()
end define

define function_name
	[id]
end define

define function_body
	[repeat variable_declaration] [repeat variable_assign] [return_statement]
	| [print_statement] [return_statement]
end define

define variable_name
    [list id]
end define

define return_type
	int
end define

define variable_declaration
	[id+] [variable_name]; [NL]
    |[id?] [id] [id] = [number]; [NL]
end define

define variable_assign
    [id] = [assigned_value]; [NL]
end define 

define assigned_value
    [number]
    |[charlit]
    |[id]
    |[assigned_value] [operator] [assigned_value]
end define

define print_statement
	printf([stringlit]); [NL]
end define

define return_statement
	return [return_value]; [NL][EX]
end define

define return_value
	[number]
end define

define operator
    '+ 
    |'-
end define

% Rules:
function main
    match [program]
	P[program]
end function