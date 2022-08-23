;; --- [ MORE TERSE OPERATORS ]------------------------------------------------
(("not" @TSOperator) (#set! conceal "¬"))
(("and" @TSOperator) (#set! conceal "∧"))
(("or"  @TSOperator) (#set! conceal "∨"))
(("in"  @TSOperator) (#set! conceal "∈"))
(("=="  @TSOperator) (#set! conceal "≡"))
(("<="  @TSOperator) (#set! conceal "≤"))
((">="  @TSOperator) (#set! conceal "≥"))
(("!="  @TSOperator) (#set! conceal "≠"))

(("lambda" @TSKeywordFunction) (#set! conceal "λ"))

;; Other ideas: https://gist.github.com/graelo/2d1f5bc6775432a5c8eb6d6c8b624011
;;  - all()   -> ∀
;;  - any()   -> ∃
;;  - len()   -> #
;;  - sum()   -> Σ
;;  - float() -> ℝ
;;  - int ()  -> ℤ


;; --- [ LESS NOISY COMPREHENSIONS ]-------------------------------------------
([(list_comprehension
    (for_in_clause
      "for" @TSRepeat))
  (set_comprehension
    (for_in_clause
      "for" @TSRepeat))
  (dictionary_comprehension
    (for_in_clause
      "for" @TSRepeat))
  (generator_expression
    (for_in_clause
      "for" @TSRepeat))]
 (#set! conceal "∀"))

([(list_comprehension
    (for_in_clause
      "in" @TSRepeat))
  (set_comprehension
    (for_in_clause
      "in" @TSRepeat))
  (dictionary_comprehension
    (for_in_clause
      "in" @TSRepeat))
  (generator_expression
    (for_in_clause
      "in" @TSRepeat))]
 (#set! conceal "∈"))

([(list_comprehension
    (if_clause
      "if" @TSRepeat))
  (set_comprehension
    (if_clause
      "if" @TSRepeat))
  (dictionary_comprehension
    (if_clause
      "if" @TSRepeat))
  (generator_expression
    (if_clause
      "if" @TSRepeat))]
 (#set! conceal "|"))


;; ----------------------------------------------------------------------------
; vim: ft=query
