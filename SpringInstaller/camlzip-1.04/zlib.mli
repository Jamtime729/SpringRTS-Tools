(***********************************************************************)
(*                                                                     *)
(*                         The CamlZip library                         *)
(*                                                                     *)
(*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         *)
(*                                                                     *)
(*  Copyright 2001 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the GNU Lesser General Public License, with     *)
(*  the special exception on linking described in file LICENSE.        *)
(*                                                                     *)
(***********************************************************************)

(* $Id: zlib.mli,v 1.2 2008/12/07 09:23:08 xleroy Exp $ *)

exception Error of string * string

val compress:
  ?level: int -> ?header: bool -> 
  (string -> int) -> (string -> int -> unit) -> unit

val compress_direct:
  ?level: int -> ?header: bool -> (string -> int -> unit) ->
  (string -> int -> int -> unit) * (unit -> unit)

val uncompress:
  ?header: bool -> (string -> int) -> (string -> int -> unit) -> unit

type stream

type flush_command =
    Z_NO_FLUSH
  | Z_SYNC_FLUSH
  | Z_FULL_FLUSH
  | Z_FINISH

external deflate_init: int -> bool -> stream = "camlzip_deflateInit"
external deflate:
  stream -> string -> int -> int -> string -> int -> int -> flush_command
         -> bool * int * int
  = "camlzip_deflate_bytecode" "camlzip_deflate"
external deflate_end: stream -> unit = "camlzip_deflateEnd"

external inflate_init: bool -> stream = "camlzip_inflateInit"
external inflate:
  stream -> string -> int -> int -> string -> int -> int -> flush_command
         -> bool * int * int
  = "camlzip_inflate_bytecode" "camlzip_inflate"
external inflate_end: stream -> unit = "camlzip_inflateEnd"

external update_crc: int32 -> string -> int -> int -> int32
                   = "camlzip_update_crc32"
