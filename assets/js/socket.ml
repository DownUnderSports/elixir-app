(* type socketParams = {
  token: string option;
  user_id: string option;
} [@@bs.deriving abstract]

type socketOpts = {
  params: socketParams
} [@@bs.deriving abstract] *)

(* type socketOpts = < params: < token: string option; user_id: string option > Js.t > Js.t;; *)
type socketOpts = < params: < token: string option; user_id: string > Js.t > Js.t

type socketType
external createSocket : string -> socketOpts -> socketType = "Socket" [@@bs.new] [@@bs.module "phoenix"]
external connectSocket : socketType -> unit = "connect" [@@bs.send]
external userToken : string option = "window.userToken" [@@bs.val];;

type location
external searchSplit : string -> string array = "split" [@@bs.scope "window", "location", "search" ] [@@bs.val];;
external get : 'a array -> int -> string = "" [@@bs.get_index]

let default =
  let socket = ([%bs.obj {params=[%bs.obj {token=userToken; user_id=(searchSplit "=" |. get 1)} ]} ] |> createSocket "/socket") in
    let _ = Js.log socket
    and _ = socket |. connectSocket in
      socket
