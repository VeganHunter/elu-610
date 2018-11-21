(* a generic error exception carrying a message and a location *)
exception Error of string * Location.t
exception Recurse

(* for debugging purpose only *)
val string_of_buffer : Lexing.lexbuf -> string

(* step back the given buffer of one character *)
val step_back : Lexing.lexbuf -> unit

(* chaining lexers *)
type 'a lexer = Lexing.lexbuf -> 'a
type 'a chainable_lexer = (Lexing.lexbuf -> 'a) -> Lexing.lexbuf -> 'a
val chain_lexer : ('a chainable_lexer) list -> 'a lexer -> Lexing.lexbuf -> 'a
