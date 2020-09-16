// 
// Code taken from the discussion on the Phoenix Live View github regarding Upload of image files:
// https://github.com/phoenixframework/phoenix_live_view/issues/104#issuecomment-557849826
//

import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"

const upload_hook = {
  file: {
    mounted() {
      this.el.addEventListener("change", e => {
        toBase64(this.el.files[0]).then(base64 => {
          var hidden = document.getElementById("values_file_base_64");
          hidden.value = base64;
          hidden.focus(); // Needed to be registered by the live view
        });
      });
    }
  }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let uploadSocket = new LiveSocket(
    "/live", 
    Socket, 
    {
        params: 
        {
            hooks: upload_hook,
            _csrf_token: csrfToken
        }
    });
uploadSocket.connect();

const toBase64 = file => new Promise((resolve, reject) => {
  const reader = new FileReader();
  reader.readAsDataURL(file);
  reader.onload = () => resolve(reader.result);
  reader.onerror = error => reject(error);
});

window.uploadSocket = uploadSocket