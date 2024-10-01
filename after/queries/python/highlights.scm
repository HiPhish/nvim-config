;; extends

;; --- [ MORE TERSE OPERATORS ]------------------------------------------------
(("not" @keyword.operator.python) (#set! conceal "¬"))
(("and" @keyword.operator.python) (#set! conceal "∧"))
(("or"  @keyword.operator.python) (#set! conceal "∨"))
(("in"  @keyword.operator.python) (#set! conceal "∈"))
(("=="  @operator.python) (#set! conceal "≡"))
(("<="  @operator.python) (#set! conceal "≤"))
((">="  @operator.python) (#set! conceal "≥"))
(("!="  @operator.python) (#set! conceal "≠"))
(("->"  @operator.python) (#set! conceal "→"))

(("lambda" @keyword.function.python) (#set! conceal "λ"))

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
      "for" @keyword.repeat.python))
  (set_comprehension
    (for_in_clause
      "for" @keyword.repeat.python))
  (dictionary_comprehension
    (for_in_clause
      "for" @keyword.repeat.python))
  (generator_expression
    (for_in_clause
      "for" @keyword.repeat.python))]
 (#set! conceal "∀"))

([(list_comprehension
    (for_in_clause
      "in" @keyword.operator.python))
  (set_comprehension
    (for_in_clause
      "in" @keyword.operator.python))
  (dictionary_comprehension
    (for_in_clause
      "in" @keyword.operator.python))
  (generator_expression
    (for_in_clause
      "in" @keyword.operator.python))]
 (#set! conceal "∈"))

([(list_comprehension
    (if_clause
      "if" @keyword.conditional.python))
  (set_comprehension
    (if_clause
      "if" @keyword.conditional.python))
  (dictionary_comprehension
    (if_clause
      "if" @keyword.conditional.python))
  (generator_expression
    (if_clause
      "if" @keyword.conditional.python))]
 (#set! conceal "|"))


;; ----------------------------------------------------------------------------
; vim: ft=query
