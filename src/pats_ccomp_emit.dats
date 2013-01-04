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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: November, 2012
//
(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_ccomp_emit"

(* ****** ****** *)

staload LAB = "./pats_label.sats"
staload STMP = "./pats_stamp.sats"

(* ****** ****** *)

staload FIL = "./pats_filename.sats"

(* ****** ****** *)

staload SYM = "./pats_symbol.sats"
staload SYN = "./pats_syntax.sats"

(* ****** ****** *)

staload GLOB = "./pats_global.sats"

(* ****** ****** *)

staload S2E = "./pats_staexp2.sats"
staload D2E = "./pats_dynexp2.sats"

(* ****** ****** *)

staload HSE = "./pats_histaexp.sats"
typedef hisexp = $HSE.hisexp
typedef hisexplst = $HSE.hisexplst

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

local

staload
TM = "libc/SATS/time.sats"
stadef time_t = $TM.time_t

in // in of [local]

implement
emit_time_stamp (out) = let
//
var tm: time_t
val () = tm := $TM.time_get ()
val (pfopt | p_tm) = $TM.localtime (tm)
//
val () = fprint_string (out, "/*\n");
val () = fprint_string (out, "**\n");
val () = fprint_string (out, "** The C code is generated by ATS/Postiats\n");
val () = fprint_string (out, "** The compilation time is: ")
//
val () =
  if p_tm > null then let
  prval Some_v @(pf1, fpf1) = pfopt
  val tm_min = $TM.tm_get_min (!p_tm)
  val tm_hour = $TM.tm_get_hour (!p_tm)
  val tm_mday = $TM.tm_get_mday (!p_tm)
  val tm_mon = 1 + $TM.tm_get_mon (!p_tm)
  val tm_year = 1900 + $TM.tm_get_year (!p_tm)
  prval () = fpf1 (pf1)
in
  fprintf (out
  , "%i-%i-%i: %2ih:%2im\n"
  , @(tm_year, tm_mon, tm_mday, tm_hour, tm_min)
  )
end else let
  prval None_v () = pfopt
in
  fprintf (out, "**UNKNOWN**\n", @())
end // end of [if]
//
val () = fprint_string (out, "**\n")
val () = fprint_string (out, "*/\n")
//
in
  fprint_newline (out)
end // end of [emit_time_stamp]

end // end of [local]

(* ****** ****** *)

implement
emit_ats_runtime_incl (out) = let
  val () = fprint_string (out, "/*\n")
  val () = fprint_string (out, "** include runtime header files\n")
  val () = fprint_string (out, "*/\n")
  val () = fprint_string (out, "#ifndef _ATS_HEADER_NONE\n")
  val () = fprint_string (out, "#include \"pats_config.h\"\n")
  val () = fprint_string (out, "#include \"pats_basics.h\"\n")
  val () = fprint_string (out, "#include \"pats_typedefs.h\"\n")
  val () = fprint_string (out, "#include \"pats_exception.h\"\n")
  val () = fprint_string (out, "#include \"pats_memalloc.h\"\n")
  val () = fprint_string (out, "#endif /* _ATS_HEADER_NONE */\n")
  val () = fprint_newline (out)
in
  fprint_newline (out)
end // end of [emit_ats_runtime_incl]

(* ****** ****** *)

implement
emit_ats_prelude_cats (out) = let
//
val () = fprint_string (out, "/*\n")
val () = fprint_string (out, "** include prelude cats files\n")
val () = fprint_string (out, "*/\n")
//
val () = fprint_string (out, "#ifndef _ATS_PRELUDE_NONE\n")
//
// HX: primary prelude cats files
//
val () = fprint_string (out, "//\n")
val () = fprint_string (out, "#include \"prelude/CATS/bool.cats\"\n")
val () = fprint_string (out, "#include \"prelude/CATS/char.cats\"\n")
val () = fprint_string (out, "#include \"prelude/CATS/float.cats\"\n")
val () = fprint_string (out, "#include \"prelude/CATS/integer.cats\"\n")
val () = fprint_string (out, "#include \"prelude/CATS/string.cats\"\n")
//
// HX: secondary prelude cats files
//
val () = fprint_string (out, "//\n")
val () = fprint_string (out, "#include \"prelude/CATS/list.cats\"\n")
val () = fprint_string (out, "#include \"prelude/CATS/option.cats\"\n")
val () = fprint_string (out, "#include \"prelude/CATS/array.cats\"\n")
val () = fprint_string (out, "#include \"prelude/CATS/matrix.cats\"\n")
//
val () = fprint_string (out, "//\n")
val () = fprint_string (out, "#endif /* _ATS_PRELUDE_NONE */\n")
//
in
  fprint_newline (out)
end // end of [emit_ats_prelude_cats]

(* ****** ****** *)

implement
emit_ident
  (out, name) = fprint_string (out, name)
// end of [emit_ident]

(* ****** ****** *)

implement
emit_label
  (out, lab) = $LAB.fprint_label (out, lab)
// end of [emit_label]

(* ****** ****** *)

implement
emit_filename
  (out, fil) = let
  val sym =
    $FIL.filename_get_full (fil)
  // end of [val]
  val name = $SYM.symbol_get_name (sym)
in
  emit_ident (out, name)
end // end of [emit_filename]

(* ****** ****** *)

implement
emit_d2con
  (out, d2c) = let
  val fil = $S2E.d2con_get_fil (d2c)
  val sym = $S2E.d2con_get_sym (d2c)
  val name = $SYM.symbol_get_name (sym)
  val () = emit_filename (out, fil)
  val () = fprint_string (out, "__")
  val () = emit_ident (out, name)
  val tag = $S2E.d2con_get_tag (d2c)
  val () = if
    tag >= 0 then let // HX: not exncon
    val () = fprintf (out, "_%i", @(tag))
  in
    // nothing
  end // end of [val]
in
  // nothing
end // end of [emit_d2con]

(* ****** ****** *)

implement
emit_d2cst
  (out, d2c) = let
  val extdef =
    $D2E.d2cst_get_extdef (d2c)
  // end of [val]
in
  case+ extdef of
  | $SYN.DCSTEXTDEFnone () => let
      val fil = $D2E.d2cst_get_fil (d2c)
      val sym = $D2E.d2cst_get_sym (d2c)
      val name = $SYM.symbol_get_name (sym)
      val () = emit_filename (out, fil)
      val () = fprint_string (out, "__")
      val () = emit_ident (out, name)
    in
      // nothing
    end // end of [DCSTEXTDEFnone]
  | $SYN.DCSTEXTDEFsome_ext name => emit_ident (out, name)
  | $SYN.DCSTEXTDEFsome_sta name => emit_ident (out, name)
  | $SYN.DCSTEXTDEFsome_mac name => emit_ident (out, name)
end // end of [emit_d2cst]

(* ****** ****** *)

implement
emit_funlab
  (out, fl) = let
//
val opt = funlab_get_qopt (fl)
//
val () = (
  case+ opt of
  | Some (d2c) => let
      val () = emit_d2cst (out, d2c)
    in
    end // end of [Some]
  | None () => let
      val () = emit_ident (out, funlab_get_name (fl))
    in
    end // end of [None]
) : void // end of [val]
in
  // nothing
end // end of [emit_funlab]

(* ****** ****** *)

implement
emit_tmpvar
  (out, tmp) = let
//
val knd = tmpvar_get_tpknd (tmp)
//
val () = (case+ 0 of
  | _ when knd = 0 => let
    in
      fprint_string (out, "tmp") // local temporary variable
    end // end of [_]
  | _ (*(static)top*) => let
    in
      fprint_string (out, "statmp") // static toplevel temporary
    end // end of [knd = 1]
) : void // end of [val]
//
val stmp = tmpvar_get_stamp (tmp)
//
in
  $STMP.fprint_stamp (out, stmp)
end // end of [emit_tmpvar]

(* ****** ****** *)

implement
emit_tmpdec
  (out, tmp) = let
  val hse = tmpvar_get_type (tmp)
  val () = emit_hisexp (out, hse)
  val () = fprint_string (out, " ")
  val () = emit_tmpvar (out, tmp)
  val () = fprint_string (out, " ; \n")
in
  // nothing
end // end of [emit_tmpdec]

implement
emit_tmpdeclst
  (out, tmps) = let
in
//
case+ tmps of
| list_cons
    (tmp, tmps) => let
    val () = emit_tmpdec (out, tmp) in emit_tmpdeclst (out, tmps)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [emit_tmpdeclst]

(* ****** ****** *)

typedef
emit_primval_type = (FILEref, primval) -> void

(* ****** ****** *)

extern fun emit_primval_tmp : emit_primval_type
extern fun emit_primval_tmpref : emit_primval_type
extern fun emit_primval_arg : emit_primval_type
extern fun emit_primval_argref : emit_primval_type
extern fun emit_primval_bool : emit_primval_type

(* ****** ****** *)

implement
emit_primval
  (out, pmv0) = let
  val loc0 = pmv0.primval_loc
in
//
case+ pmv0.primval_node of
| PMVtmp _ => emit_primval_tmp (out, pmv0)
| PMVtmpref _ => emit_primval_tmpref (out, pmv0)
| PMVarg _ => emit_primval_arg (out, pmv0)
(*
| PMVargref _ => emit_primval_argref (out, pmv0)
*)
| PMVbool _ => emit_primval_bool (out, pmv0)
//
| PMVi0nt (tok) => $SYN.fprint_i0nt (out, tok)
| PMVf0loat (tok) => $SYN.fprint_f0loat (out, tok)
//
| _ => let
(*
    val () = prerr_interror_loc (loc0)
    val () = (
      prerr ": emit_primval: pmv0 = "; prerr pmv0; prerr_newline ()
    ) // end of [val]
    val () = assertloc (false)
*)
  in
    fprint_primval (out, pmv0)
  end // end of [_]
//
end // end of [emit_primval]

(* ****** ****** *)

implement
emit_primvalist
  (out, pmvs) = let
//
fun loop (
  out: FILEref, pmvs: primvalist, i: int
) : void = let
in
//
case+ pmvs of
| list_cons
    (pmv, pmvs) => let
    val () =
      if i > 0 then fprint_string (out, ", ")
    // end of [val]
    val () = emit_primval (out, pmv)
  in
    loop (out, pmvs, i+1)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [loop]
//
in
  loop (out, pmvs, 0)
end // end of [emit_primvalist]

(* ****** ****** *)

implement
emit_primval_tmp
  (out, pmv0) = let
//
val- PMVtmp (tmp) = pmv0.primval_node
//
in
  emit_tmpvar (out, tmp)
end // end of [emit_primval_tmp]

implement
emit_primval_tmpref
  (out, pmv0) = let
//
val- PMVtmpref (tmp) = pmv0.primval_node
//
in
  emit_tmpvar (out, tmp)
end // end of [emit_primval_tmpref]

(* ****** ****** *)

implement
emit_primval_arg
  (out, pmv0) = let
//
val- PMVarg (ind) = pmv0.primval_node
//
in
  fprintf (out, "arg%i", @(ind))
end // end of [emit_primval_arg]

(* ****** ****** *)

implement
emit_primval_bool
  (out, pmv0) = let
//
val- PMVbool (b) = pmv0.primval_node
val name = (
  if b then "atsbool_true" else "atsbool_false"
) : string // end of [val]
//
in
  fprint_string (out, name)
end (* end of [emit_primval_bool] *)

(* ****** ****** *)

implement
emit_tmpvar_assgn
  (out, tmp, pmv) = {
  val () = emit_tmpvar (out, tmp)
  val () = fprint_string (out, " = ")
  val () = emit_primval (out, pmv)
} // end of [emit_tmpvar_assgn]

(* ****** ****** *)

implement
emit_hisexp
  (out, hse) = let
in
  $HSE.fprint_hisexp (out, hse)
end // end of [emit_hisexp]

implement
emit_hisexplst_sep
  (out, hses, sep) = let
//
fun loop (
  out: FILEref
, hses: hisexplst, sep: string, i: int
) : void = let
in
  case+ hses of
  | list_cons (
      hse, hses
    ) => let
      val () =
        if i > 0 then fprint_string (out, sep)
      // end of [val]
      val () = emit_hisexp (out, hse)
    in
      loop (out, hses, sep, i+1)
    end // end of [list_cons]
  | list_nil () => ()
end // end of [loop]
//
in
  loop (out, hses, sep, 0)
end // end of [emit_hisexplst_sep]

(* ****** ****** *)

implement
emit_funtype_arg_res (
  out, hses_arg, hse_res
) = let
  val () = emit_hisexp (out, hse_res)
  val () = fprint_string (out, "(*)(")
  val () = emit_hisexplst_sep (out, hses_arg, ", ")
  val () = fprint_string (out, ")")
in
  // nothing
end // end of [emit_funtype_arg_res]

(* ****** ****** *)

typedef
emit_instr_type = (FILEref, instr) -> void

extern fun emit_instr_funcall : emit_instr_type

(* ****** ****** *)

implement
emit_instr
  (out, ins) = let
//
val loc0 = ins.instr_loc
//
// generating #line progma for debugging
//
val gline =
  $GLOB.the_DEBUGATS_dbgline_get ()
val () = (
  if gline > 0 then $LOC.fprint_line_pragma (out, loc0)
) : void // end of [val]
//
val gflag =
  $GLOB.the_DEBUGATS_dbgflag_get ()
val () = (
//
// HX: generating debug information
//
  if gflag > 0 then let
    val () = fprint_string (out, "/* ")
    val () = fprint_instr (out, ins)
    val () = fprint_string (out, " */\n")
  in
    // empty
  end // end of [if]
) : void // end of [val]
//
in
//
case+ ins.instr_node of
//
| INSfunlab (fl) => {
    val () =
      fprint_string (out, "__pats_lab_")
    val () = emit_funlab (out, fl)
    val () = fprint_string (out, ":")
  } // end of [INSfunlab]
//
| INSmove_val
    (tmp, pmv) => {
    val isvoid = primval_is_void (pmv)
    val () = if isvoid then fprint_string (out, "/* ")
    val () = emit_tmpvar_assgn (out, tmp, pmv)
    val () = if isvoid then fprint_string (out, " */")
    val () = fprint_string (out, " ;")
  } // end of [INSmove_val]
//
| INSfuncall _ => emit_instr_funcall (out, ins)
//
| INScond (
    pmv_cond, inss_then, inss_else
  ) => {
    val () = fprint_string (out, "if (")
    val () = emit_primval (out, pmv_cond)
    val () = fprint_string (out, ") {\n")
    val () = emit_instrlst (out, inss_then)
    val () = fprint_string (out, "\n} else {\n")
    val () = emit_instrlst (out, inss_else)
    val () =
      fprint_string (out, "\n} /* end of [if] */")
    // end of [val]
  } // end of [INScond]
//
| INSletpop () => let
    val () = fprint_string (out, "/*\n")
    val () = fprint_instr (out, ins)
    val () = fprint_string (out, "\n*/")
  in
    // nothing
  end // end of [INSletpop]
| INSletpush (pmds) => let
    val () = fprint_string (out, "/*\n")
    val () = fprint_instr (out, ins)
    val () = fprint_string (out, "\n*/\n")
    val () = emit_primdeclst (out, pmds)
  in
    // nothing
  end // end of [INSletpush]
//
| _ => let
    val () = prerr_interror_loc (loc0)
    val () = (
      prerr ": emit_instr: ins = "; prerr_instr (ins); prerr_newline ()
    ) // end of [val]
    val () = assertloc (false)
  in
    // nothing
  end // end of [_]
end // end of [emit_instr]

(* ****** ****** *)

implement
emit_instrlst
  (out, inss) = let
//
fun loop (
  out: FILEref, inss: instrlst, sep: string, i: int
) : void = let
in
//
case+ inss of
| list_cons
    (ins, inss) => let
    val () =
      if i > 0 then
        fprint_string (out, sep)
      // end of [if]
    val () = emit_instr (out, ins)
  in
    loop (out, inss, sep, i+1)
  end // end of [list_cons]
| list_nil () => let
    val () =
      if i = 0 then fprint_string (out, "/* (*nothing*) */")
    // end of [val]
  in
    // nothing
  end // end of [list_nil]
//
end // end of [loop]
//
in
  loop (out, inss, "\n", 0)
end // end of [emit_instrlst]    

implement
emit_instrlst_ln
  (out, inss) = let
  val () =
    emit_instrlst (out, inss) in fprint_string (out, "\n")
  // end of [val]
end // end of [emit_instrlst_ln]

(* ****** ****** *)

implement
emit_instr_funcall
  (out, ins) = let
//
val loc0 = ins.instr_loc
val- INSfuncall
  (tmp, pmv_fun, hse_fun, pmvs_arg) = ins.instr_node
(*
val () = (
  println! ("emit_instr_funcall: pmv_fun = ", pmv_fun)
) // end of [val]
*)
val isvoid = false
val () = if isvoid then fprint_string (out, "/* ")
val () = (
  emit_tmpvar (out, tmp); fprint_string (out, " = ")
) // end of [val]
val () = if isvoid then fprint_string (out, "*/ ")
//
in
//
case+ pmv_fun.primval_node of
//
| PMVfunlab (fl) => let
    val () = emit_funlab (out, fl)
    val () = fprint_string (out, "(")
    val () = emit_primvalist (out, pmvs_arg)
    val () = fprint_string (out, ") ;")
  in
    // nothing
  end // end of [PMVfun]
//
| PMVtmpltcst _ => let
    val () = emit_primval (out, pmv_fun)
    val () = fprint_string (out, "(")
    val () = emit_primvalist (out, pmvs_arg)
    val () = fprint_string (out, ") ;")
  in
    // nothing
  end // end of [PMVtmpltcst]
| PMVtmpltcstmat _ => let
    val () = emit_primval (out, pmv_fun)
    val () = fprint_string (out, "(")
    val () = emit_primvalist (out, pmvs_arg)
    val () = fprint_string (out, ") ;")
  in
    // nothing
  end // end of [PMVtmpltcstmat]
//
| PMVtmpltvar _ => let
    val () = emit_primval (out, pmv_fun)
    val () = fprint_string (out, "(")
    val () = emit_primvalist (out, pmvs_arg)
    val () = fprint_string (out, ") ;")
  in
    // nothing
  end // end of [PMVtmpltvar]
//
| _(*function variable*) => let
    val () = emit_primval (out, pmv_fun)
    val () = fprint_string (out, "(")
    val () = emit_primvalist (out, pmvs_arg)
    val () = fprint_string (out, ") ;")
  in
    // nothing
  end // end of [_]
//
(*
| _ => let
    val () = prerr_interror_loc (loc0)
    val () = (
      prerr ": emit_instr_funcall: hse_fun = "; $HSE.prerr_hisexp (hse_fun); prerr_newline ()
    ) // end of [val]
    val () = assertloc (false)
  in
    // nothing
  end // end of [_]
*)
//
end // end of [emit_instr_funcall]

(* ****** ****** *)

implement
emit_funarglst
  (out, hses) = let
//
fun loop (
  out: FILEref
, hses: hisexplst, sep: string, i: int
) : void = let
in
//
case+ hses of
| list_cons
    (hse, hses) => let
    val () =
      if i > 0 then fprint_string (out, sep)
    val () = emit_hisexp (out, hse)
    val () = fprintf (out, " arg%i", @(i))
  in
    loop (out, hses, sep, i+1)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [loop]
//
in
  loop (out, hses, ", ", 0)
end // end of [emit_funarglst]

(* ****** ****** *)

local

fun auxfun (
  out: FILEref, fent: funent
) : void = let
//
  val fl = funent_get_lab (fent)
  val opt = funlab_get_qopt (fl)
  val isext = (
    case+ opt of Some _ => true | None _ => false
  ) : bool // end of [val]
  val issta = not (isext)
//
  val () = if isext then fprint_string (out, "/*\n")
//
  val () = if isext then fprint_string (out, "extern\n")
  val () = if issta then fprint_string (out, "static\n")
//
  val () =
    emit_hisexp (out, hse_res) where {
    val hse_res = funlab_get_type_res (fl)
  }
//
  val () = fprint_string (out, "\n")
  val () = emit_funlab (out, fl)
  val () = fprint_string (out, " (")
//
  val () =
    emit_funarglst (out, hses_arg) where {
    val hses_arg = funlab_get_type_arg (fl)
  } // end of [val]
//
  val () = fprint_string (out, ") ;")
  val () = if isext then fprint_string (out, "\n*/")
//
  val () = fprint_newline (out)
//
in
  // nothing
end // end of [auxfun]

in // in of [local]

implement
emit_funent_ptype
  (out, fent) = let
//
  val () = auxfun (out, fent)
//
in
  // nothing
end // end of [emit_funentry_ptype]

end // end of [local]

(* ****** ****** *)

local

fun auxtmp (
  out: FILEref, fent: funent
) : void = let
//
val imparg = funent_get_imparg (fent)
val tmparg = funent_get_tmparg (fent)
val () = fprint_string (out, "/*\n")
val () = fprint_string (out, "imparg = ")
val () = $S2E.fprint_s2varlst (out, imparg)
val () = fprint_string (out, "\n")
val () = fprint_string (out, "tmparg = ")
val () = $S2E.fprint_s2explstlst (out, tmparg)
val () = fprint_string (out, "\n")
val () = fprint_string (out, "*/\n")
//
in
  // nothing
end // end of [auxtmp]

in // in of [local]

implement
emit_funent_implmnt
  (out, fent) = let
//
val locent = funent_get_loc (fent)
//
val fl = funent_get_lab (fent)
//
val fc = funlab_get_funclo (fl)
val hses_arg = funlab_get_type_arg (fl)
val hse_res = funlab_get_type_res (fl)
//
val tmpret = funent_get_tmpret (fent)
//
// function header
//
val qopt = funlab_get_qopt (fl)
val isext = (
  case+ qopt of Some _ => true | None _ => false
) : bool // end of [val]
val issta = not (isext)
val () =
  if isext then fprint_string (out, "ATSglobaldec()\n")
val () =
  if issta then fprint_string (out, "ATSstaticdec()\n")
//
val istmp = funent_is_tmplt (fent)
val () = if istmp then auxtmp (out, fent)
//
val () = emit_hisexp (out, hse_res)
val () = fprint_string (out, "\n")
val () = emit_funlab (out, fl)
val () = fprint_string (out, " (")
val () = emit_funarglst (out, hses_arg)
val () = fprint_string (out, ")\n")
//
// function body
//
val () = fprint_string (out, "{\n")
val tmplst = funent_get_tmpvarlst (fent)
val () = fprint_string (out, "/* tmpdeclst: beg */\n")
val () = emit_tmpdeclst (out, tmplst)
val () = fprint_string (out, "/* tmpdeclst: end */\n")
val body_inss = funent_get_instrlst (fent)
val () = emit_instrlst (out, body_inss)
val () = fprint_string (out, "\n")
//
// function return
//
val () = fprint_string (out, "\n")
val () = fprint_string (out, "return ")
val isvoid = tmpvar_is_void (tmpret)
val () =
  if isvoid then fprint_string (out, "/* ")
val () = emit_tmpvar (out, tmpret)
val () =
  if isvoid then fprint_string (out, " */")
val () = fprint_string (out, " ;")
//
val () = fprint_string (out, "\n}")
val () =
  fprint_string (out, " /* end of [")
val () = emit_funlab (out, fl)
val () = fprint_string (out, "] */\n")
//
in
end // end of [emit_funent_implmnt]

end // end of [local]

(* ****** ****** *)

local

staload UN = "prelude/SATS/unsafe.sats"

fun emit_primdec
  (out: FILEref, pmd: primdec) : void = let
in
//
case+ pmd.primdec_node of
//
| PMDnone () => ()
//
| PMDimpdec _ => ()
//
| PMDfundecs _ => ()
//
| PMDvaldecs
    (knd, hvds, inss) =>
    emit_instrlst_ln (out, $UN.cast{instrlst}(inss))
| PMDvaldecs_rec (knd, hvds, inss) =>
    emit_instrlst_ln (out, $UN.cast{instrlst}(inss))
//
| PMDvardecs (hvds, inss) =>
    emit_instrlst_ln (out, $UN.cast{instrlst}(inss))
//
| PMDstaload _ => ()
//
| PMDlocal (
    pmds_head, pmds_body
  ) => {
    val () =
      fprint_string (out, "/* local */\n")
    val () = emit_primdeclst (out, pmds_head)
    val () =
      fprint_string (out, "/* in of [local] */\n")
    val () = emit_primdeclst (out, pmds_body)
    val () =
      fprint_string (out, "/* end of [local] */\n")
    // end of [val]
  } // end of [PMDlocal]
//
end // end of [emit_primdec]

in // in of [local]

implement
emit_primdeclst
  (out, pmds) = let
in
//
case+ pmds of
| list_cons
    (pmd, pmds) => let
    val () =
      emit_primdec (out, pmd) in emit_primdeclst (out, pmds)
    // end of [val]
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [emit_primdeclst]

end // end of [local]

(* ****** ****** *)

(* end of [pats_ccomp_emit.dats] *)
