type socketParams = {
  token: string option;
  user_id: string option;
} [@@bs.deriving abstract]

type socketOpts = {
  params: socketParams
} [@@bs.deriving abstract]

type socketType
type connection
type channel
external createSocket : string -> socketOpts -> socketType = "Socket" [@@bs.new] [@@bs.module "phoenix"]
external connectSocket : socketType -> unit = "connect" [@@bs.send]
external openChannel : socketType -> string -> < > Js.t -> channel = "channel" [@@bs.send]
external joinChannel : channel -> unit = "join" [@@bs.send]

type presenceType
type presenceEvent
type presenceData
external createPresence : channel -> presenceType = "Presence" [@@bs.new] [@@bs.module "phoenix"];;
external presenceOnSync : presenceType -> ('a -> unit) = "onSync" [@@bs.send];;
external listPresence : presenceType -> ('a ->  'b) = "list" [@@bs.send]

external userToken : string option = "window.userToken" [@@bs.val];;

type location
external searchSplit : string -> string array = "split" [@@bs.scope "window", "location", "search" ] [@@bs.val];;
external get : 'a array -> int -> string option = "" [@@bs.get_index]

let _ =
  Js.log (searchSplit "=" |. get 1)

let _params = socketParams ~token:userToken ~user_id:(searchSplit "=" |. get 1);;
let _opts = socketOpts ~params:_params;;

let socket = createSocket "/socket" _opts;;
let channel =
  socket |. openChannel "page:lobby" (Js.Obj.empty ())

let presence = createPresence channel

let onPresenceSync =
  [%raw {|
    () => {
      let result = ''
      presence.list((id, {metas: [first, ...rest]}) => {
        let count = rest.length + 1
        result += `${id} (count: ${count})\n`
      })
      console.log(result)
    }
  |}]
let _ =
  ( presence |. presenceOnSync onPresenceSync )

let _ =
  ( socket |. connectSocket)

let _ =
  ( channel |. joinChannel)

let default = socket
