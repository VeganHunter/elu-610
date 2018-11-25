open ExprAst
open PfxAst

let rec generate = function
  | Const c -> string_of_int c
  | Binop(op,e1,e2) -> "(" ^(generate e1)^(generate e2)^(BinOp.string_of op)^ ")"
  | Uminus e ->  "(0" ^(generate e)^"min)"
  | Var v -> failwith "Not yet supported"


