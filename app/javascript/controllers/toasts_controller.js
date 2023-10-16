import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toasts"
export default class extends Controller {
  connect() {
        // Find the close button within the toast element
    const closeButton = this.element.querySelector("[data-action='click->toasts#close']");

    // Add a click event listener to the close button
    if (closeButton) {
      closeButton.addEventListener("click", () => {
        // Hide the toast element when the close button is clicked
        this.element.style.display = "none";
      });
    }
  }
}
