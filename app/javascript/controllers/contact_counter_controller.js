import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["counter", "list"]

  connect() {
    this.updateCounter()
    document.addEventListener('turbo:frame-load', this.updateCounter.bind(this))
    document.addEventListener('turbo:render', this.updateCounter.bind(this))
  }

  disconnect() {
    document.removeEventListener('turbo:frame-load', this.updateCounter.bind(this))
    document.removeEventListener('turbo:render', this.updateCounter.bind(this))
  }

  updateCounter() {
    const table = this.element.querySelector("table")
    if (table) {
      const rows = table.querySelectorAll("tbody tr")
      this.counterTarget.textContent = rows.length
    } else {
      this.counterTarget.textContent = "0"
    }
  }
}
