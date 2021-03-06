(* ****** ****** *)
//
// HX-2015-07:
// A running example
// from ATS2 to Erlang
//
(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 0
//
(* ****** ****** *)

%{^
%%
-module(fact2_dats).
%%
-export([fact/1]).
-export([mytest/0]).
%%
-compile(nowarn_unused_vars).
-compile(nowarn_unused_function).
%%
-include("./libatscc2erl/libatscc2erl_all.hrl").
%%
%} // end of [%{]

(* ****** ****** *)
//
#define
LIBATSCC2ERL_targetloc
"$PATSHOME\
/contrib/libatscc2erl/ATS2-0.3.2"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2ERL}/SATS/float.sats"
//
(* ****** ****** *)
//
extern
fun
fact : double -> double = "mac#fact"
//
implement
fact (n) = let
//
fnx loop
(
  n: double, res: double
) : double =
  if n > 0.0 then loop (n-1.0, n*res) else res
//
in
  loop (n, 1.0)
end // end of [fact]

(* ****** ****** *)

%{$
mytest() ->
  N = 12
, io:format("fact(~p) = ~p~n", [N, fact(N)])
. %% mytest()
%} // end of [%{$]

(* ****** ****** *)

(* end of [fact2.dats] *)
