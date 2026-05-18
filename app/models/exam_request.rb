class ExamRequest < ApplicationRecord
  belongs_to :student

  has_many :exam_request_subjects, dependent: :destroy
  has_many :subjects, through: :exam_request_subjects
end
