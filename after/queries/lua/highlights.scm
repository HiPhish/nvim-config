;; extends

;; --- [ MORE TERSE OPERATORS ]------------------------------------------------
(("not" @keyword.operator.lua) (#set! conceal "¬"))
(("and" @keyword.operator.lua) (#set! conceal "∧"))
(("or"  @keyword.operator.lua) (#set! conceal "∨"))
(("in"  @keyword.operator.lua) (#set! conceal "∈"))
(("<="  @operator.) (#set! conceal "≤"))
((">="  @operator.) (#set! conceal "≥"))
(("~="  @operator.) (#set! conceal "≠"))

(function_definition
  "function" @keyword.function.lua (#set! conceal "λ"))


;; ----------------------------------------------------------------------------
; vim: ft=query
