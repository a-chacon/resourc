import {
  Controller
} from "@hotwired/stimulus"

// Connects to data-controller="drop-down-menu"
export default class extends Controller {
  static targets = ["menu"];

  toggle() {
    this.menuTarget.classList.toggle("hidden");
  }
}
