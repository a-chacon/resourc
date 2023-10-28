import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tag-input"
export default class extends Controller {
  static targets = ["tagInput", "tagList","tagSuggestionList" ]
  static values = { suggestionsUrl: String }

  connect() {
    this.tags = []
    this.suggestedTags = []
  }

  addTagFromSuggestion(event){
    console.log(event.inputType)
    if (event.inputType == "insertReplacementText"){
      this.addTag(event)
    }
  }

  addTag(event) {
    event.preventDefault()
    const tag = event.target.value.trim()

    if (tag !== "" && this.tags.length < 3) {
      this.tags.push(tag)
      this.renderTags()
      this.tagInputTarget.value = "" // Clear the input field
    }
  }

  removeTag(event) {
    const index = event.target.dataset.index
    this.tags.splice(index, 1)
    this.renderTags()
  }

  renderTags() {
    this.tagListTarget.innerHTML = this.tags
      .map((tag, index) => `
        <span class="px-2 py-1 rounded-xl text-xs bg-gradient-to-r from-blue-600 to-purple-700 text-white hover:scale-110 transition ease-in-out delay-50 duration-200">
          <input type="hidden" class="form-control" placeholder="Search Box" name="tags[]" value="${tag}">
          <button data-action="click->tag-input#removeTag" data-index="${index}" class="ml-2">${tag} X</button>
        </span>
      `)
      .join("")
  }

  async fetchSuggestions() {
    const tag = this.tagInputTarget.value
    if (tag.length > 2) {
      try {
        const response = await fetch(`${this.suggestionsUrlValue}?tag=${tag}`)
        const data = await response.json()
        this.suggestedTags = data
        this.tagSuggestionListTarget.innerHTML = this.suggestedTags
        .map(tag => `
          <option >${tag}</option>
        `)
        .join("")
      } catch (error) {
        console.error("Error fetching tag suggestions:", error)
      }
    } else {
      this.suggestedTags = []
      this.tagSuggestionListTarget.innerHTML = ""
    }
  }
}
