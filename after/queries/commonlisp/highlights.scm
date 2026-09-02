;; SPDX-FileCopyrightText: © 2022 HiPhish
;; SPDX-License-Identifier: 0BSD

;; extends

;; --- [ MORE TERSE OPERATORS ]------------------------------------------------
((defun_header
   keyword: (defun_keyword) @function.macro.commonlisp
            (#eq? @function.macro.commonlisp "lambda"))
 (#set! conceal "λ"))

((list_lit
   . value: (sym_lit) @function.builtin.commonlisp
            (#match? @function.builtin.commonlisp "^[aA][nN][dD]$"))
 (#set! conceal "∧"))

((list_lit
   . value: (sym_lit) @function.builtin.commonlisp
            (#match? @function.builtin.commonlisp "^[oO][rR]$"))
 (#set! conceal "∨"))

((list_lit
   . value: (sym_lit) @function.builtin.commonlisp
            (#match? @function.builtin.commonlisp "^[nN][oO][tT]$"))
 (#set! conceal "¬"))


;; ----------------------------------------------------------------------------
; vim: ft=query
