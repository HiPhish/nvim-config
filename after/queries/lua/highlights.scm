;; extends

;; --- [ MORE TERSE OPERATORS ]------------------------------------------------
(("not" @keyword.operator.lua) (#set! conceal "¬"))
(("and" @keyword.operator.lua) (#set! conceal "∧"))
(("or"  @keyword.operator.lua) (#set! conceal "∨"))
(("in"  @keyword.operator.lua) (#set! conceal "∈"))
(("<="  @operator.) (#set! conceal "≤"))
((">="  @operator.) (#set! conceal "≥"))
(("~="  @operator.) (#set! conceal "≠"))

;; ----------------------------------------------------------------------------
; vim: ft=query
