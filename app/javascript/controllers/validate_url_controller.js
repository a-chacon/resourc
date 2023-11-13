import {
  Controller
} from "@hotwired/stimulus"

// Connects to data-controller="validate-url"
export default class extends Controller {
  static targets = ["urlInput", "warning"];
  connect(){
  console.log("WORKING1")
  }

  validateUrl(event) {

    const url = this.urlInputTarget.value;
    const urlRegex = /^(ftp|http|https):\/\/[^ "]+$/;

    if (urlRegex.test(url)) {
      // URL is valid, continue with the normal form submission
      this.warningTarget.style.display = "none";
    } else {
      // URL is invalid, show a warning message
      this.warningTarget.style.display = "block";
      event.preventDefault();
    }
  }
}
