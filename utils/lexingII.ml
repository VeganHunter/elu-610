open Lexing

exception Error of string * Location.t
exception Recurse

let string_of_buffer buffer =
  Printf.sprintf
    "buffer len %i abs %i start_pos %i curr_pos %i last_pos %i start %i current %i"
    buffer.lex_buffer_len buffer.lex_abs_pos buffer.lex_start_pos buffer.lex_curr_pos
    buffer.lex_last_pos (buffer.lex_start_p.pos_cnum) (buffer.lex_curr_p.pos_cnum)

let step_back buffer =
  buffer.lex_curr_p <- { buffer.lex_curr_p with pos_cnum = buffer.lex_curr_p.pos_cnum - 1; } ;
  buffer.lex_curr_pos <- buffer.lex_curr_pos-1

type 'a lexer = lexbuf -> 'a

type 'a chainable_lexer = (lexbuf -> 'a) -> lexbuf -> 'a

let chain_lexer lexers final_lexer (buffer:lexbuf) =
  let rec chain_rec lexers buffer =
    match lexers with
    | []  -> final_lexer buffer
    | [l] -> l final_lexer buffer
    | l::t -> l (chain_rec t) buffer
  in
  chain_rec lexers buffer
