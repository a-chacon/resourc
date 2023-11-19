import {
  Controller
} from "@hotwired/stimulus"

// Connects to data-controller="mobile-sidebar"
export default class extends Controller {

  static targets = ["sidebar", "list", "openIcon", "closeIcon"]

  toggleSideBar() {
    this.sidebarTarget.classList.toggle('hidden');
    this.listTarget.classList.toggle('hidden');
    this.openIconTarget.classList.toggle("hidden")
    this.closeIconTarget.classList.toggle("hidden")
  }
}
