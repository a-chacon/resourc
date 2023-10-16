import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    console.log("Conected modal")
  }
  static targets = ["wrapper", "dialog"]

  open() {
    this.wrapperTarget.classList.remove("hidden")
  }

  close() {
    this.wrapperTarget.classList.add("hidden")
  }
}
