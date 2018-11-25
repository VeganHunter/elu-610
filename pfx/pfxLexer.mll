{
  open PfxParser

  let mk_int nb loc =
    try INT (int_of_string nb)
    with Failure _ -> raise (LexingII.Error(Printf.sprintf "Illegal integer '%s': " nb,loc))
}

let newline = (['\n' '\r'] | "\r\n")
let blank = [' ' '\014' '\t' '\012']
let not_newline_char = [^ '\n' '\r']
let digit = ['0'-'9']
let integer = digit+

rule token = parse
  (* newlineslexbuf *)
  | newline { Location.incr_line lexbuf; token lexbuf }
  (* blanks *)
  | blank + { token lexbuf }
  (* end of file *)
  | eof      { EOF }
  (* comments *)
  | "--" not_newline_char*  { token lexbuf }
  (* integers *)
  | integer as nb           { mk_int nb (Location.curr lexbuf)}
  (* commands  *)
  | "+"      { Add }
  | "-"      { Sub }
  | "/"      { Div }
  | "*"      { Mul }
  | "%"      { Rem }
  | "("      { LPAR }
  | ")"      { RPAR }
  (* illegal characters *)
  | _ as c  {
      raise (LexingII.Error(Printf.sprintf "Illegal character '%c': " c, Location.curr lexbuf))
    }
