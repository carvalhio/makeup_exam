class ExamRequest < ApplicationRecord
  belongs_to :student
  belongs_to :exam_period

  has_many :exam_request_subjects, dependent: :destroy
  has_many :subjects, through: :exam_request_subjects

  def application_shift
    student_shift = student.school_class.shift

    return student_shift if same_shift?

    student_shift == "Manhã" ? "Tarde" : "Manhã"
  end

  def display_subjects
  return subjects.map(&:name).join(", ") unless exam_period.exam_type == "Global"

  names = subjects.pluck(:name)

  areas = []

  areas << "Linguagens" if (
    names & [
      "Língua Portuguesa",
      "Língua Inglesa",
      "Língua Espanhola",
      "Literatura",
      "Arte"
    ]
  ).any?

  areas << "Ciências da Natureza" if (
    names & [
      "Biologia",
      "Física",
      "Química"
    ]
  ).any?

  areas << "Matemática" if names.include?("Matemática")

  areas << "Ciências Humanas" if (
    names & [
      "História",
      "Geografia",
      "Filosofia",
      "Sociologia"
    ]
  ).any?

    areas << "Redação" if names.include?("Redação")

    areas << "Educação Física" if names.include?("Educação Física")

    areas.join(", ")
  end
end
