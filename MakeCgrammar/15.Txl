% Grammar:
compounds 
    '&& '|| '>= '<= '== '++
end compounds

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
	[statement+]
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
	printf[SPOFF]([SPON][stringlit]); [NL]
    | printf[SPOFF]([SPON][stringlit][SPOFF],[id][SPON]); [NL]
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
    |'*
    |'/
end define

define statement 
    [variable_assign] 
    |[variable_declaration]
    |[print_statement]
    |[return_statement]
    |[input_statement]
    |[if_condition_statement]
    |[switch_statement]
    |[for_loop_statement]
    |[while_loop_statement]
end define

define input_statement
    [id][SPOFF]([SPON][stringlit],[input_operator][SPOFF][id][SPON]);[NL]
end define

define input_operator
    &
end define

define if_condition_statement
    if([condition_expression])
    [NL][condition_statement]
    [else_condition_statement*]
end define

define condition_operator
    '>
    |'<
    |'==
    |'!=
    |'>=
    |'<=
end define

define else_condition_statement
    else 
    [NL][condition_statement]   
end define

define open_brace
    '{ [NL]
end define

define close_brace
    '} [NL]
end define

define condition_statement_brace
    [open_brace][IN]
    [statement+][EX]
    [close_brace]
end define

define condition_statement
    [condition_statement_brace]
    |[IN][statement][EX]
end define

define logic_operator
    '|| | '&& |'!
end define

define logic_expression
    [assigned_value][condition_operator][assigned_value]
end define

define condition_expression
    [logic_expression]
    |[logic_operator?][SPOFF]([SPON][condition_expression])
    |[condition_expression][logic_operator][condition_expression]
    |([condition_expression])
end define

define switch_statement
    [id]([id])[NL]
    [open_brace]
    [case_statement*]
    [default_statement]
    [close_brace]
end define

define case_statement
[IN][id][charlit][SPOFF]:[SPON][EX]
[NL][IN][IN][statement][EX][EX]
[IN][IN][id];[EX][EX][NL]
end define

define default_statement
[IN][id][SPOFF]:[SPON][EX]
[NL][IN][IN][statement][EX][EX]
end define

define for_loop_statement
    for([for_loop_condition])[NL]
    [condition_statement]
end define

define variable_expression
    [id] = [assigned_value]
end define 

define if_check_expression
    [SPOFF];[assigned_value][SPON][condition_operator][assigned_value]
end define

define for_loop_condition
    [variable_expression][if_check_expression][SPOFF];[loop_increment_expression][SPON]
end define

define loop_increment_expression
    [SPOFF][id]++[SPON]
end define

define while_loop_statement
    while([condition_expression])[NL]
    [open_brace]
    [IN][SPOFF][loop_increment_expression];[SPON][NL]
    [statement][EX]
    [close_brace]
end define

% Rules:
function main
    match [program]
	P[program]
end function