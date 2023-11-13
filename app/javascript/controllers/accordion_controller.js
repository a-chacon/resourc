import {
  Controller
} from "@hotwired/stimulus"

// Connects to data-controller="accordion"
export default class extends Controller {
  connect() {
    this.accordionItems = this.element.querySelectorAll('.cursor-pointer');
    this.accordionItems.forEach(item => {
      item.addEventListener('click', this.toggleAccordion.bind(this));
    });
  }

  toggleAccordion(event) {
    const item = event.currentTarget;
    const body = item.nextElementSibling;
    body.classList.toggle('hidden');
  }
}
