(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// HX-2016-05:
//
(* ****** ****** *)
//
extern
fun{}
neg_real:
  {x:real}
  (real(x)) -<fun> real(~x)
//
overload ~ with neg_real
overload neg with neg_real
//
(* ****** ****** *)
//
extern
fun{}
add_real_real
  {x,y:real}
  (real(x), real(y)):<> real(x+y)
//
extern
fun{}
sub_real_real
  {x,y:real}
  (real(x), real(y)):<> real(x-y)
//
extern
fun{}
mul_real_real
  {x,y:real}
  (real(x), real(y)):<> real(x*y)
//
extern
fun{}
div_real_real
  {x,y:real}
  (real(x), real(y)):<> real(x/y)
//
overload + with add_real_real
overload - with sub_real_real
overload * with mul_real_real
overload / with div_real_real
//
(* ****** ****** *)
//
extern
fun{}
lt_real_real
  {x,y:real}
  (real(x), real(y)):<> bool(x < y)
extern
fun{}
lte_real_real
  {x,y:real}
  (real(x), real(y)):<> bool(x <= y)
//
extern
fun{}
gt_real_real
  {x,y:real}
  (real(x), real(y)):<> bool(x > y)
extern
fun{}
gte_real_real
  {x,y:real}
  (real(x), real(y)):<> bool(x >= y)
//
extern
fun{}
eq_real_real
  {x,y:real}
  (real(x), real(y)):<> bool(x == y)
extern
fun{}
neq_real_real
  {x,y:real}
  (real(x), real(y)):<> bool(x != y)
//
overload < with lt_real_real
overload <= with lte_real_real
//
overload > with gt_real_real
overload >= with gte_real_real
//
overload = with eq_real_real
overload != with neq_real_real
//
(* ****** ****** *)
//
extern
fun{}
int2real
  {i:int}(i: int(i)): real(i2r(i))
//
(* ****** ****** *)
//
extern
fun{}
abs_real:
  {x:real} (real(x)) -<fun> real(abs(x))
//
overload abs with abs_real
//
(* ****** ****** *)
//
extern
fun{}
sqrt_real:
  {x:real | x >= i2r(0)} (real(x)) -<fun> real(sqrt(x))
//
overload sqrt with sqrt_real
//
(* ****** ****** *)
//
extern
fun{}
print_real0(real0): void
extern
fun{}
prerr_real0(real0): void
extern
fun{}
fprint_real0(FILEref, real0): void
//
overload print with print_real0
overload prerr with prerr_real0
overload fprint with fprint_real0
//
(* ****** ****** *)

(* end of [real.sats] *)