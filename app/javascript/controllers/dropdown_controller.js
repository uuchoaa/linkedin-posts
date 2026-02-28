import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel"]

  connect() {
    this.boundHide = this.hide.bind(this)
  }

  toggle(event) {
    event.stopPropagation()
    const isOpen = this.panelTarget.classList.toggle("hidden")
    if (!isOpen) {
      document.addEventListener("click", this.boundHide, { once: true })
    }
  }

  hide() {
    this.panelTarget.classList.add("hidden")
  }
}
