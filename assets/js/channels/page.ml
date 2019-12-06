type socket
type channel
type expr
external socket : socket = "default" [@@bs.module "socket.bs"];;
external openChannel : socket -> string -> < > Js.t -> channel = "channel" [@@bs.send]
external joinChannel : channel -> channel = "join" [@@bs.send]
external receiveFromChannel : channel -> string -> (string -> unit) -> channel = "receive" [@@bs.send]
external log : 'a -> 'b -> unit = "console.log" [@@bs.val]

type element
type dom
external querySelector: string -> element = "document.querySelector" [@@bs.val]
external setInnerHtml: element -> 'a -> 'b = "innerHTML" [@@bs.set]

type presenceType
type socketType
external createPresence : channel -> presenceType = "Presence" [@@bs.new] [@@bs.module "phoenix"];;
external presenceOnSync : presenceType -> ('a -> unit) = "onSync" [@@bs.send];;
external listPresence : presenceType -> ('a ->  unit) = "list" [@@bs.send]

let default =
  let channel =
    openChannel socket "page:lobby" (Js.Obj.empty ())
  in
  let presence =
    channel |. createPresence
  in
  let onPresenceSync () =
    let result = ref "" in
    let listFunc = fun [@bs] id item ->
      let count = Js.Array.length item##metas in
      result := {j|<br>$id (count: $count)</br>|j}
    in
    let _ = presence |. (listPresence listFunc) in
    let _ = Js.log !result in
    let _ =
      try
        querySelector "#active-users"
        |. setInnerHtml result
      with
        | Js.Exn.Error e ->
            match Js.Exn.message e with
            | Some message -> Js.log {j|Error: $message|j}
            | None -> Js.log "An unknown error occurred"

    in
      ()
  in
  let _ =
    presence |. presenceOnSync onPresenceSync
  and _ =
    let positiveResponse resp = log "Joined successfully" resp in
    let negativeResponse resp = log "Unable to join" resp in
    channel
    |. joinChannel
    |. receiveFromChannel "ok" positiveResponse
    |. receiveFromChannel "error" negativeResponse;
  in
    channel
