import {
  Controller
} from "@hotwired/stimulus"

// Connects to data-controller="dark-mode"
export default class extends Controller {
  static targets = ["button", "sunIcon", "moonIcon"];

  connect() {
    this.setInitialDarkMode();
  }

  toggleDarkMode() {
    var htmlElement = document.documentElement;

    const darkMode = htmlElement.classList.toggle("dark");
    localStorage.setItem("darkMode", darkMode);
    if (darkMode){
      this.moonIconTarget.style.display="block";
      this.sunIconTarget.style.display="none";
    }else{
      this.moonIconTarget.style.display="none";
      this.sunIconTarget.style.display="block";
    }
  }

  setInitialDarkMode() {
    const darkMode = JSON.parse(localStorage.getItem("darkMode"));
    if (darkMode) {
      var htmlElement = document.documentElement;
      htmlElement.classList.add("dark");
      this.moonIconTarget.style.display="block";
      this.sunIconTarget.style.display="none";
    }
  }
}
