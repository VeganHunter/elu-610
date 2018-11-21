type command = Add | Mul | Sub | Div | Rem | Push of int | Pop | Swap (* Question 4.1 *)

type program = int * command list

(* add here all useful functions and types  related to the AST: for instance  string_of_ functions *)

let rec string_of_command = function
  | Add -> "add"
  | Mul -> "mul"
  | Sub -> "sub"
  | Div -> "div"
  | Rem -> "rem"
  | Push n -> "push " ^ (string_of_int n)
  | Pop -> "pop"
  | Swap -> "swap"

let string_of_commands cmds = String.concat " " (List.map string_of_command cmds)

open Printf
let string_of_program (args, cmds) =
  sprintf "%i args: %s\n" args (string_of_commands cmds)
