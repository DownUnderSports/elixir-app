

let () = Js.log "Hello, BuckleScripts"
let () = Js.log "Hello, BuckleScripts2"
external random: unit -> float = "random" [@@bs.val][@@bs.scope "Math"]
