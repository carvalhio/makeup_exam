import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [
    "schoolClass",
    "student"
  ]

  async loadStudents() {

    const schoolClassId =
      this.schoolClassTarget.value

    if (!schoolClassId) {
      return
    }

    const response =
      await fetch(
        `/school_classes/${schoolClassId}/students`
      )

    const students =
      await response.json()

    this.studentTarget.innerHTML = ""

    students.forEach((student) => {

      const option =
        document.createElement("option")

      option.value = student.id
      option.textContent = student.name

      this.studentTarget.appendChild(option)

    })
  }
}