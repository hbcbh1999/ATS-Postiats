(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: May, 2011
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/pointer.dats"
staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload STP = "pats_stamp.sats"
staload SYM = "pats_symbol.sats"
overload = with $SYM.eq_symbol_symbol

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"

(* ****** ****** *)

fun prerr_interror (): void = prerr "INTERROR(pats_staexp2_sort)"

(* ****** ****** *)

typedef
s2rtdat_struct = @{
  s2rtdat_sym= symbol // name
, s2rtdat_conlst= s2cstlst
, s2rtdat_stamp= stamp // unique stamp
} // end of [s2rtdat_struct]

(* ****** ****** *)

local

assume s2rtdat_type = ref (s2rtdat_struct)

in // in of [local]

implement
s2rtdat_make (id) = let
//
  val stamp = $STP.s2rtdat_stamp_make ()
  val (pfgc, pfat | p) = ptr_alloc<s2rtdat_struct> ()
  prval () = free_gc_elim (pfgc)
//
  val () = p->s2rtdat_sym := id
  val () = p->s2rtdat_conlst := list_nil ()
  val () = p->s2rtdat_stamp := stamp
//
in // in of [let]
  ref_make_view_ptr (pfat | p)
end // end of [s2rtdat_make]

implement
s2rtdat_get_sym (s2td) = let
  val (vbox pf | p) = ref_get_view_ptr (s2td) in p->s2rtdat_sym
end // end of [s2rtdat_get_sym]

implement
s2rtdat_get_conlst (s2td) = let
  val (vbox pf | p) = ref_get_view_ptr (s2td) in p->s2rtdat_conlst
end // end of [s2rtdat_get_conlst]
implement
s2rtdat_set_conlst (s2td, cs) = let
  val (vbox pf | p) = ref_get_view_ptr (s2td) in p->s2rtdat_conlst := cs
end // end of [s2rtdat_set_conlst]

implement
s2rtdat_get_stamp (s2td) = let
  val (vbox pf | p) = ref_get_view_ptr (s2td) in p->s2rtdat_stamp
end // end of [s2rtdat_get_stamp]

implement
eq_s2rtdat_s2rtdat
  (x1, x2) = p1 = p2 where {
  val p1 = ref_get_ptr (x1) and p2 = ref_get_ptr (x2)
} // end of [eq_s2rtdat_s2rtdat]

end // end of [local]

(* ****** ****** *)

local

val s2tb_int: s2rtbas = S2RTBASpre ($SYM.symbol_INT)
val s2tb_bool: s2rtbas = S2RTBASpre ($SYM.symbol_BOOL)
val s2tb_addr: s2rtbas = S2RTBASpre ($SYM.symbol_ADDR)
val s2tb_char: s2rtbas = S2RTBASpre ($SYM.symbol_CHAR)
val s2tb_cls: s2rtbas = S2RTBASpre ($SYM.symbol_CLS)
val s2tb_eff: s2rtbas = S2RTBASpre ($SYM.symbol_EFF)

in // in of [local]

implement s2rt_int = S2RTbas s2tb_int
implement s2rt_bool = S2RTbas s2tb_bool
implement s2rt_addr = S2RTbas s2tb_addr
implement s2rt_char = S2RTbas s2tb_char
implement s2rt_cls = S2RTbas s2tb_cls
implement s2rt_eff = S2RTbas s2tb_eff

end // end of [local]

(* ****** ****** *)

local
//
#include "pats_basics.hats"
//
val s2tb_prop: s2rtbas = S2RTBASimp ($SYM.symbol_PROP, PROP_int)
val s2tb_prop_pos: s2rtbas = S2RTBASimp ($SYM.symbol_PROP, PROP_pos_int)
val s2tb_prop_neg: s2rtbas = S2RTBASimp ($SYM.symbol_PROP, PROP_neg_int)
//
val s2tb_type: s2rtbas = S2RTBASimp ($SYM.symbol_TYPE, TYPE_int)
val s2tb_type_pos: s2rtbas = S2RTBASimp ($SYM.symbol_TYPE, TYPE_pos_int)
val s2tb_type_neg: s2rtbas = S2RTBASimp ($SYM.symbol_TYPE, TYPE_neg_int)
//
val s2tb_t0ype: s2rtbas = S2RTBASimp ($SYM.symbol_T0YPE, T0YPE_int)
val s2tb_t0ype_pos: s2rtbas = S2RTBASimp ($SYM.symbol_T0YPE, T0YPE_pos_int)
val s2tb_t0ype_neg: s2rtbas = S2RTBASimp ($SYM.symbol_T0YPE, T0YPE_neg_int)
//
val s2tb_view: s2rtbas = S2RTBASimp ($SYM.symbol_VIEW, VIEW_int)
val s2tb_view_pos: s2rtbas = S2RTBASimp ($SYM.symbol_VIEW, VIEW_pos_int)
val s2tb_view_neg: s2rtbas = S2RTBASimp ($SYM.symbol_VIEW, VIEW_neg_int)
//
val s2tb_viewtype: s2rtbas = S2RTBASimp ($SYM.symbol_VIEWTYPE, VIEWTYPE_int)
val s2tb_viewtype_pos: s2rtbas = S2RTBASimp ($SYM.symbol_VIEWTYPE, VIEWTYPE_pos_int)
val s2tb_viewtype_neg: s2rtbas = S2RTBASimp ($SYM.symbol_VIEWTYPE, VIEWTYPE_neg_int)
//
val s2tb_viewt0ype: s2rtbas = S2RTBASimp ($SYM.symbol_VIEWT0YPE, VIEWT0YPE_int)
val s2tb_viewt0ype_pos: s2rtbas = S2RTBASimp ($SYM.symbol_VIEWT0YPE, VIEWT0YPE_pos_int)
val s2tb_viewt0ype_neg: s2rtbas = S2RTBASimp ($SYM.symbol_VIEWT0YPE, VIEWT0YPE_neg_int)
//
val s2tb_types: s2rtbas = S2RTBASimp ($SYM.symbol_TYPES, T0YPE_int)
//
in // in of [local]

implement s2rt_prop = S2RTbas s2tb_prop
implement s2rt_prop_pos = S2RTbas s2tb_prop_pos
implement s2rt_prop_neg = S2RTbas s2tb_prop_neg

implement s2rt_type = S2RTbas s2tb_type
implement s2rt_type_pos = S2RTbas s2tb_type_pos
implement s2rt_type_neg = S2RTbas s2tb_type_neg

implement s2rt_t0ype = S2RTbas s2tb_t0ype
implement s2rt_t0ype_pos = S2RTbas s2tb_t0ype_pos
implement s2rt_t0ype_neg = S2RTbas s2tb_t0ype_neg

implement s2rt_view = S2RTbas s2tb_view
implement s2rt_view_pos = S2RTbas s2tb_view_pos
implement s2rt_view_neg = S2RTbas s2tb_view_neg

implement s2rt_viewtype = S2RTbas s2tb_viewtype
implement s2rt_viewtype_pos = S2RTbas s2tb_viewtype_pos
implement s2rt_viewtype_neg = S2RTbas s2tb_viewtype_neg

implement s2rt_viewt0ype = S2RTbas s2tb_viewt0ype
implement s2rt_viewt0ype_pos = S2RTbas s2tb_viewt0ype_pos
implement s2rt_viewt0ype_neg = S2RTbas s2tb_viewt0ype_neg

implement s2rt_types = S2RTbas s2tb_types

implement
s2rt_impredicative
  (knd) = let
in
//
case+ knd of
//
| PROP_int => s2rt_prop
| TYPE_int => s2rt_type
| T0YPE_int => s2rt_t0ype
| VIEW_int => s2rt_view
| VIEWTYPE_int => s2rt_viewtype
| VIEWT0YPE_int => s2rt_viewt0ype
//
| PROP_pos_int => s2rt_prop_pos
| PROP_neg_int => s2rt_prop_neg
| TYPE_pos_int => s2rt_type_pos
| TYPE_neg_int => s2rt_type_neg
| T0YPE_pos_int => s2rt_t0ype_pos
| T0YPE_neg_int => s2rt_t0ype_neg
| VIEW_pos_int => s2rt_view_pos
| VIEW_neg_int => s2rt_view_neg
| VIEWTYPE_pos_int => s2rt_viewtype_pos
| VIEWTYPE_neg_int => s2rt_viewtype_neg
| VIEWT0YPE_pos_int => s2rt_viewt0ype_pos
| VIEWT0YPE_neg_int => s2rt_viewt0ype_neg
//
| _ => let
//
    val () = prerr_interror ()
    val () = prerr ": s2rt_impredicative: knd = "
    val () = prerr_int (knd)
    val () = prerr_newline ()
    val () = assertloc (false)
  in
    s2rt_t0ype // HX: this is deadcode
  end // end of [s2rt_impredicative]
//
end // end of [s2rt_impredicative]

end // end of [local]

(* ****** ****** *)

implement
s2rt_is_dat (s2t) = (case+ s2t of
  | S2RTbas s2tb => (
      case+ s2tb of S2RTBASdef _ => true | _ => false
    ) // end of [S2RTbas]
  | _ => false // end of [S2RTbas]
) // end of [s2rt_is_dat]

implement
s2rt_is_fun (s2t) =
  case+ s2t of S2RTfun _ => true | _ => false
// end of [s2rt_is_fun]

implement
s2rt_is_prf (s2t) = (case+ s2t of
  | S2RTbas s2tb => (case+ s2tb of
    | S2RTBASimp (_, knd) => test_prfkind (knd) | _ => false
    ) // end of [S2RTbas]
  | _ => false // end of [_]
) // end of [s2rt_is_prf]

implement
s2rt_is_prgm (s2t) = (case+ s2t of
  | S2RTbas s2tb => (case+ s2tb of
    | S2RTBASimp (_, knd) => test_prgmkind (knd) | _ => false
    ) // end of [S2RTbas]
  | _ => false // end of [_]
) // end of [s2rt_is_prgm]

implement
s2rt_is_lin (s2t) = (
  case+ s2t of
  | S2RTbas s2tb => (case+ s2tb of
    | S2RTBASimp (_, knd) => test_linkind (knd) | _ => false
    ) // end of [S2RTbas]
  | _ => false // end of [_]
) // end of [s2rt_is_lin]

implement
s2rt_is_impredicative
  (s2t) = case+ s2t of
  | S2RTbas s2tb => (
      case+ s2tb of S2RTBASimp _ => true | _ => false
    ) // end of [S2RTbas]
  | _ => false
// end of [s2rt_is_impredicative]

implement
s2rt_get_pol (s2t) = case+ s2t of
  | S2RTbas (s2tb) => (case+ s2tb of
    | S2RTBASimp (_, knd) => test_polkind (knd) | _ => 0
    ) // end of [S2RTbas]
  | _ => 0 // polarity is neutral
// end of [s2rt_get_pol]

(* ****** ****** *)

abstype s2rtnul (l:addr)
typedef s2rtnul = [l:agez] s2rtnul (l)

(* ****** ****** *)

extern
castfn s2rtnul_none (x: ptr null): s2rtnul (null)

extern
castfn s2rtnul_some (x: s2rt): [l:agz] s2rtnul (l)
extern
castfn s2rtnul_unsome {l:agz} (x: s2rtnul l): s2rt

extern
fun s2rtnul_is_null {l:addr}
  (x: s2rtnul (l)): bool (l==null) = "atspre_ptr_is_null"
// end of [s2rtnul_is_null]
extern
fun s2rtnul_isnot_null {l:addr}
  (x: s2rtnul (l)): bool (l > null) = "atspre_ptr_isnot_null"
// end of [s2rtnul_isnot_null]

(* ****** ****** *)

local
//
assume s2rtVar = ref (s2rtnul)
//
in // in of [local]

implement
eq_s2rtVar_s2rtVar
  (x1, x2) = (p1 = p2) where {
  val p1 = ref_get_ptr (x1) and p2 = ref_get_ptr (x2)
} // end of [eq_s2rtVar_s2rtVar]

implement
compare_s2rtVar_s2rtVar
  (x1, x2) = compare_ptr_ptr (p1, p2) where {
  val p1 = ref_get_ptr (x1) and p2 = ref_get_ptr (x2)
} // end of [compare_s2rtVar_s2rtVar]

(* ****** ****** *)

implement
s2rtVar_make (loc) = let
  val nul = s2rtnul_none (null) in ref_make_elt (nul)
end // end of [s2rtVar_make]

(* ****** ****** *)

implement
s2rt_delink (s2t0) = let
  fun aux (s2t0: s2rt): s2rt =
    case+ s2t0 of
    | S2RTVar r => let
        val s2t = !r
        val test = s2rtnul_isnot_null (s2t)
      in
        if test then let
          val s2t = s2rtnul_unsome (s2t)
          val s2t = aux (s2t)
          val () = !r := s2rtnul_some (s2t)
        in
          s2t
        end else s2t0
      end (* S2RTVar *)
    | _ => s2t0 // end of [_]
  // end of [aux]
in
  aux (s2t0)
end // end of [s2rt_delink]

implement
s2rt_delink_all (s2t0) = let
//
  fun aux (
    s2t0: s2rt, flag: &int
  ) : s2rt =
    case+ s2t0 of
    | S2RTfun (s2ts, s2t) => let
        val flag0 = flag
        val s2ts = auxlst (s2ts, flag)
        val s2t = aux (s2t, flag)
      in
        if flag > flag0 then S2RTfun (s2ts, s2t) else s2t0
      end
    | S2RTtup (s2ts) => let
        val flag0 = flag
        val s2ts = auxlst (s2ts, flag)
      in
        if flag > flag0 then S2RTtup (s2ts) else s2t0
      end
    | S2RTVar r => let
        val s2t = !r
        val isnotnull = s2rtnul_isnot_null (s2t)
      in
        if isnotnull then let
          val s2t = s2rtnul_unsome (s2t)
          val s2t = aux (s2t, flag)
          val () = !r := s2rtnul_some (s2t)
          val () = flag := flag + 1
        in
          s2t
        end else s2t0 // end of [if]
      end (* S2RTVar *)
    | _ => s2t0
  (* end of [aux] *)
//
  and auxlst (
    s2ts0: s2rtlst, flag: &int
  ) : s2rtlst =
    case+ s2ts0 of
    | list_cons (s2t, s2ts) => let
        val flag0 = flag
        val s2t = aux (s2t, flag)
        val s2ts = auxlst (s2ts, flag)
      in
        if flag > flag0 then list_cons (s2t, s2ts) else s2ts0
      end
    | list_nil () => list_nil ()
  (* end if [auxlst] *)
//
  var flag: int = 0
//
in
  aux (s2t0, flag)
end // end of [s2rt_delink_all]

(* ****** ****** *)

implement
s2rtVar_set_s2rt (s2tV, s2t) = let
  val s2t = s2rtnul_some (s2t) in !s2tV := s2t 
end // end of [s2rtVar_set_s2rt]

implement
s2rtVar_occurscheck
  (V, s2t0) = let
//
fun aux (
  s2t0: s2rt
) :<cloref1> bool =
  case+ s2t0 of
  | S2RTbas _ => false
  | S2RTfun (s2ts, s2t) =>
      if auxlst (s2ts) then true else aux (s2t)
    // end of [S2RTfun]
  | S2RTtup (s2ts) => auxlst (s2ts)
  | S2RTVar (V1) =>
      if V = V1 then true else let
        val s2t1 = !V1
      in
        if s2rtnul_isnot_null (s2t1) then
          aux (s2rtnul_unsome (s2t1)) else false
        // end of [if]
      end (* end of [if] *)
  | S2RTerr () => false
//
and auxlst (
  s2ts: s2rtlst
) :<cloref1> bool =
  case+ s2ts of
  | list_cons (s2t, s2ts) =>
      if aux (s2t) then true else auxlst (s2ts)
    // end of [list_cons]
  | list_nil () => false
//
in
  aux (s2t0)
end // end of [s2rtVar_occurcheck]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

implement
s2rt_fun (_arg, _res) = S2RTfun (_arg, _res)

implement
s2rt_tup (s2ts) = S2RTtup (s2ts) // HX: tuple sort not yet supported

implement s2rt_err () = S2RTerr () // HX: error indication

(* ****** ****** *)

extern
fun lte_s2rtbas_s2rtbas
  (s2tb1: s2rtbas, s2tb2: s2rtbas): bool
overload <= with lte_s2rtbas_s2rtbas

implement
lte_s2rtbas_s2rtbas (s2tb1, s2tb2) = begin
  case+ (s2tb1, s2tb2) of
  | (S2RTBASpre id1, S2RTBASpre id2) => (id1 = id2)
  | (S2RTBASimp (id1, knd1),
     S2RTBASimp (id2, knd2)) => lte_impkind_impkind (knd1, knd2)
  | (S2RTBASdef s2td1, S2RTBASdef s2td2) => (s2td1 = s2td2)
  | (_, _) => false
end // end of [lte_s2rtbas_s2rtbas]

(* ****** ****** *)

(*
** HX: knd=0/1: dry-run / real-run
*)
extern
fun s2rt_ltmat (s2t1: s2rt, s2t2: s2rt, knd: int): bool
extern
fun s2rtlst_ltmat (xs1: s2rtlst, xs2: s2rtlst, knd: int): bool

implement
s2rt_ltmat
  (s2t1, s2t2, knd) = let
//
  fun auxVar (
    V: s2rtVar, s2t: s2rt, knd: int
  ) : bool =
    if knd > 0 then let
      val test = s2rtVar_occurscheck (V, s2t)
    in
      if test then false else let
        val () = s2rtVar_set_s2rt (V, s2t) in true
      end (* end of [if] *)
    end else
      true // HX: a dry run always succeeds
    // end of [auxVar]
//
  val s2t1 = s2rt_delink (s2t1)
  and s2t2 = s2rt_delink (s2t2)
//
in
//
case+ s2t1 of
| S2RTbas (s2tb1) => (case+ s2t2 of
  | S2RTbas (s2tb2) => s2tb1 <= s2tb2 | _ => false
  )
| S2RTfun (
    s2ts1, s2t1
  ) => (case+ s2t2 of
  | S2RTfun (s2ts2, s2t2) =>
     if s2rtlst_ltmat (s2ts2, s2ts1, knd)
       then s2rt_ltmat (s2t1, s2t2, knd) else false
    // end of [S2RTfun]
  | _ => false
  )
| S2RTtup (s2ts1) => (case+ s2t2 of
  | S2RTtup (s2ts2) => s2rtlst_ltmat (s2ts1, s2ts2, knd) | _ => false
  )
| S2RTVar (V1) => (case+ s2t2 of
  | S2RTVar (V2) when V1 = V2 => true | _ => auxVar (V1, s2t2, knd)
  )
| S2RTerr () => false
//
end // end of [s2rt_ltmat]

implement
s2rtlst_ltmat (xs1, xs2, knd) =
  case+ (xs1, xs2) of
  | (list_cons (x1, xs1), list_cons (x2, xs2)) =>
      if s2rt_ltmat (x1, x2, knd) then s2rtlst_ltmat (xs1, xs2, knd) else false
  | (list_nil (), list_nil ()) => true
  | (_, _) => false
// end of [s2rtlst_ltmat]

(* ****** ****** *)

implement s2rt_ltmat0 (x1, x2) = s2rt_ltmat (x1, x2, 0)
implement s2rt_ltmat1 (x1, x2) = s2rt_ltmat (x1, x2, 1)

(* ****** ****** *)

(* end of [pats_staexp2_sort.dats] *)
