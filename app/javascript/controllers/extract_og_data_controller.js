import {
  Controller
} from "@hotwired/stimulus"

// Connects to data-controller="extract-og-data"
export default class extends Controller {

  static targets = ["url", "title", "description"]
  static values = {
    ogUrl: String
  }

  connect() {
    console.log("conected to link")
  }

  async fetchOpenGraph() {
    console.log("calling function")
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
