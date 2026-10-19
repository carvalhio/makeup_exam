import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]

  search() {
    clearTimeout(this.searchTimeout)

    const name = this.inputTarget.value.trim()

    if (name.length < 2) {
      this.resultsTarget.replaceChildren()
      this.resultsTarget.hidden = true
      return
    }

    this.searchTimeout = setTimeout(() => {
      this.performSearch(name)
    }, 300)
  }

  async performSearch(name) {
    try {
      const response = await fetch(
        `/api/v1/students?name=${encodeURIComponent(name)}`,
        {
          headers: {
            Accept: "application/json"
          }
        }
      )

      if (!response.ok) {
        throw new Error("Falha ao buscar alunos")
      }

      const students = await response.json()

      // Evita exibir resultados de uma pesquisa anterior.
      if (this.inputTarget.value.trim() !== name) {
        return
      }

      this.resultsTarget.replaceChildren()

      students.forEach(student => {
        const link = document.createElement("a")

        link.href = `/students/${student.id}`
        link.textContent = student.name
        link.className = "dropdown-item"

        this.resultsTarget.appendChild(link)
      })

      this.resultsTarget.hidden = students.length === 0
    } catch (error) {
      console.error("Erro na busca de alunos:", error)
      this.resultsTarget.replaceChildren()
      this.resultsTarget.hidden = true
    }
  }

  closeOnOutsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.resultsTarget.hidden = true
    }
  }

  closeOnEscape(event) {
    if (event.key === "Escape") {
      clearTimeout(this.searchTimeout)
      this.resultsTarget.hidden = true
      this.inputTarget.blur()
    }
  }

  disconnect() {
    clearTimeout(this.searchTimeout)
  }
}
