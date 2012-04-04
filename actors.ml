type local_actor = {
  local_mailbox : message Queue.t;
  local_handler : (message -> unit);
}

type remote_actor = {
  remote_ip : string;
  remote_port : int;
}

type actor = {
  actor_localid : int; (* local number of the actor when it was created *)
  actor_host : string; (* uniq identifier of the machine on which it was created (20-byte string generated randomly at startup) *)
}

type local_or_remote =
  | LocalActor of local_actor
  | RemoteActor of remote_actor

let actors = Hashtbl.create 1313 (* Should probably be a weak hashtbl *)



type arg =
  | Actor of actor

  | C of char
  | S of string
  | I of int
  | F of float

  | L of arg list
  | A of arg array
  | D of (string * arg) list

  | LC of char list
  | LS of string list
  | LI of int list
  | LF of float list

  | AC of char array
  | AS of string array
  | AI of int array
  | AF of float array

type message = string * arg list

val create : (actor -> unit) -> actor
val receive : actor -> (message -> unit) -> unit
val send : actor -> msg -> unit
