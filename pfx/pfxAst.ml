type command = add | mul | sub | div | rem | push of int | pop | swap (* Question 4.1 *)

type program = int * command list

(* add here all useful functions and types  related to the AST: for instance  string_of_ functions *)

let rec string_of_command = function
  | add -> "add"
  | mul -> "mul"
  | sub -> "sub"
  | div -> "div"
  | rem -> "rem"
  | push n -> "push " ^ (string_of_int n)
  | pop -> "pop"
  | swap -> "swap"

let string_of_commands cmds = String.concat " " (List.map string_of_command cmds)

open Printf
let string_of_program (args, cmds) =
  sprintf "%i args: %s\n" args (string_of_commands cmds)
