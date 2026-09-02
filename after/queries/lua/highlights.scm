;; SPDX-FileCopyrightText: © 2023 HiPhish
;; SPDX-License-Identifier: 0BSD

;; extends

;; --- [ MORE TERSE OPERATORS ]------------------------------------------------
(("not" @keyword.operator.lua) (#set! conceal "¬"))
(("and" @keyword.operator.lua) (#set! conceal "∧"))
(("or"  @keyword.operator.lua) (#set! conceal "∨"))
(("in"  @keyword.operator.lua) (#set! conceal "∈"))
(("<="  @operator.lua) (#set! conceal "≤"))
((">="  @operator.lua) (#set! conceal "≥"))
(("~="  @operator.lua) (#set! conceal "≠"))

(for_statement
  "for" @keyword.repeat.lua (#set! conceal "∀"))

(function_definition
  "function" @keyword.function.lua (#set! conceal "λ"))


;; ----------------------------------------------------------------------------
; vim: ft=query
