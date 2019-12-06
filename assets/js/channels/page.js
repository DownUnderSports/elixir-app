import { Presence } from "phoenix"
import socket from 'socket.bs'

const channel = socket.channel("page:lobby", {})
const presence = new Presence(channel)

const renderOnlineUsers = () => {
  let list = ""

  presence.list(
    (id, { metas = [] }) =>
      list += `<br>${id} (count: ${metas.length})</br>`
  )

  try {
    document.querySelector("#active-users").innerHTML = list
  } catch(err) {
    console.error(err)
  }

}

presence.onSync(renderOnlineUsers)

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })
