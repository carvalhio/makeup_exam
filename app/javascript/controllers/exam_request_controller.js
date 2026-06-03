import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [
    "schoolClass",
    "student"
  ]

  loadStudents() {
  const schoolClassId = this.schoolClassTarget.value

  if (!schoolClassId) {
    this.studentTarget.innerHTML =
      '<option value="">Selecione um aluno</option>'
    return
  }

  const examPeriodId =
  this.element.dataset.examRequestPeriodIdValue

  fetch(
    `/school_classes/${schoolClassId}/students.json?exam_period_id=${examPeriodId}`
  )
    .then(response => response.json())
    .then(students => {
      this.studentTarget.innerHTML =
        '<option value="">Selecione um aluno</option>'

      students.forEach(student => {
        const option = document.createElement("option")

        option.value = student.id
        option.textContent = student.name

        if (student.has_request) {
          option.disabled = true
          option.textContent += " (já cadastrado)"
        }

        this.studentTarget.appendChild(option)
      })
    })
  }
}