// Generated by BUCKLESCRIPT, PLEASE EDIT WITH CARE

import * as Phoenix from "phoenix";

var socket = new Phoenix.Socket("/socket", {
      params: {
        token: window.userToken,
        user_id: window.location.search.split("=")[1]
      }
    });

console.log(socket);

socket.connect();

var $$default = socket;

export {
  $$default ,
  $$default as default,
  
}
/* socket Not a pure module */
