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
end
