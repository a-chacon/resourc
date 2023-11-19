import {
  Controller
} from "@hotwired/stimulus"

// Connects to data-controller="reactions"
export default class extends Controller {
  static values = {
    link: Number,
    like: String,
    dislike: String
  }
  static targets = ["buttonUp", "buttonDown", "count"]

  connect() {
    if (this.likeValue !== "") {
      this.buttonUpTarget.classList.add('text-rose-500')
    } else if (this.dislikeValue !== "") {
      this.buttonDownTarget.classList.add("text-rose-500")
    }
  }

  voteUp() {
    const token = document.querySelector('meta[name="csrf-token"]').content;

    if (this.likeValue !== "") {
      const response = fetch('/user_links/' + this.likeValue, {
          method: 'DELETE',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': token,
          },
        })
        .then(response => {
          if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
          }
          this.likeValue = "";
          return response.json();
        })
        .then(data => {
          // Process the response data
          console.log(data);
          this.countTarget.innerHTML = data.link.reaction_like
          this.likeValue = ""
        })
        .catch(error => {
          // Handle errors
          console.error('Fetch error:', error);
        });
    } else {
      const response = fetch('/user_links', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': token
          },
          body: JSON.stringify({
            link_id: this.linkValue,
            relationship_type: "like"
          })
        })
        .then(response => {
          if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
          }
          return response.json();
        })
        .then(data => {
          // Process the response data
          console.log(data);
          this.countTarget.innerHTML = data.link.reaction_like
          this.likeValue = data.user_link.id
          this.dislikeValue = ""
          this.buttonDownTarget.classList.remove("text-rose-500")
        })
        .catch(error => {
          // Handle errors
          console.error('Fetch error:', error);
        });

    }
    
    this.buttonUpTarget.classList.toggle('text-rose-500')
  }

  voteDown(){
    const token = document.querySelector('meta[name="csrf-token"]').content;

    if (this.dislikeValue !== "") {
      const response = fetch('/user_links/' + this.dislikeValue, {
          method: 'DELETE',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': token,
          },
        })
        .then(response => {
          if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
          }
          this.dislikeValue = "";
          return response.json();
        })
        .then(data => {
          // Process the response data
          console.log(data);
          this.dislikeValue = ""
        })
        .catch(error => {
          // Handle errors
          console.error('Fetch error:', error);
        });
    } else {
      const response = fetch('/user_links', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': token
          },
          body: JSON.stringify({
            link_id: this.linkValue,
            relationship_type: "dislike"
          })
        })
        .then(response => {
          if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
          }
          return response.json();
        })
        .then(data => {
          // Process the response data
          console.log(data);

          this.countTarget.innerHTML = data.link.reaction_like
          this.buttonUpTarget.classList.remove("text-rose-500")
          this.likeValue = ""
          this.dislikeValue = data.user_link.id
        })
        .catch(error => {
          // Handle errors
          console.error('Fetch error:', error);
        });
    }
    this.buttonDownTarget.classList.toggle('text-rose-500')
  }


}
