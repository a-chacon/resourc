import { Application } from "@hotwired/stimulus"
import { BlurhashController } from "stimulus-blurhash";

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

Stimulus.register("blurhash", BlurhashController);

export { application }
