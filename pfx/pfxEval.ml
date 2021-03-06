open PfxAst
open Printf

type state = command list * int list

let string_of_stack stack = sprintf "[%s]" (String.concat ";" (List.map string_of_int stack))

let string_of_state (cmds,stack) =
  (match cmds with
   | [] -> "no command"
   | cmd::_ -> sprintf "executing %s" (string_of_command cmd))^
    (sprintf " with stack %s" (string_of_stack stack))

(* Question 4.2 *)
let step state =
  match state with
  (* Errors *)
  | [], _                                                               -> Error ("Nothing to step",state)
  | (Add | Mul | Sub | Div | Rem | Pop | Swap)  :: _, []                -> Error ("Zero arguments", state) 
  | (Add | Mul | Sub | Div | Rem | Swap)        :: _, _ :: []           -> Error ("Only one argument", state) 
  | (Div | Rem)                                 :: _, _ :: 0 :: _       -> Error ("Division by 0", state)
  (* Valid configurations *)
  | Add       :: q, a :: b :: stack	    -> Ok (q, (a+b) :: stack)
  | Mul       :: q, a :: b :: stack  	-> Ok (q, (a*b) :: stack)
  | Sub       :: q, a :: b :: stack	    -> Ok (q, (a-b) :: stack)
  | Div       :: q, a :: b :: stack	    -> Ok (q, (a/b) :: stack)
  | Rem       :: q, a :: b :: stack	    -> Ok (q, (a mod b) :: stack)
  | Push of n :: q, stack               -> Ok (q, n :: stack)
  | Pop       :: q, a :: stack		    -> Ok (q, stack)
  | Swap      :: q, a :: b :: stack		-> Ok (q, b :: a :: stack)

let eval_program (numargs, cmds) args =
  let rec execute = function
    | [], []    -> Ok None
    | [], v::_  -> Ok (Some v)
    | state ->
       begin
         match step state with
         | Ok s    -> execute s
         | Error e -> Error e
       end
  in
  if numargs = List.length args then
    match execute (cmds,args) with
    | Ok None -> printf "No result\n"
    | Ok(Some result) -> printf "= %i\n" result
    | Error(msg,s) -> printf "Raised error %s in state %s\n" msg (string_of_state s)
  else printf "Raised error \nMismatch between expected and actual number of args\n"
