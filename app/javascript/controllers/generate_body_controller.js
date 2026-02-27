import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "textarea"]
  static values = { url: String }

  async generate(event) {
    event.preventDefault()
    if (!this.hasButtonTarget || !this.hasTextareaTarget || !this.urlValue) return

    const button = this.buttonTarget
    const textarea = this.textareaTarget
    const originalText = button.innerHTML

    button.disabled = true
    button.innerHTML = "Generating..."

    const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content

    try {
      const response = await fetch(this.urlValue, {
        method: "POST",
        headers: {
          "X-CSRF-Token": csrfToken,
          "Accept": "application/json",
          "Content-Type": "application/json"
        }
      })

      const data = await response.json()

      if (response.ok && data.body) {
        textarea.value = data.body
      } else {
        alert(data.error || "Failed to generate body")
      }
    } catch (err) {
      alert("Failed to generate body. Is Ollama running?")
    } finally {
      button.disabled = false
      button.innerHTML = originalText
    }
  }
}
