import {
  Controller
} from "@hotwired/stimulus"

// Connects to data-controller="extract-og-data"
export default class extends Controller {

  static targets = ["url", "title", "description"]
  static values = {
    ogUrl: String
  }

  connect() {}

  isValidHttpUrl(string) {
    try {
      const newUrl = new URL(string);
      return newUrl.protocol === 'http:' || newUrl.protocol === 'https:';
    } catch (err) {
      return false;
    }
  }

  async fetchOpenGraph() {
    if (this.isValidHttpUrl(this.urlTarget.value)) {
      const url = this.urlTarget.value
      try {
        const response = await fetch(`${this.ogUrlValue}?url=${url}`)
        const data = await response.json()
        this.titleTarget.value = data.title
        this.descriptionTarget.value = data.description
      } catch (error) {
        console.error("Error fetching tag suggestions:", error)
      }
    }
  }
}
