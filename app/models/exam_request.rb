class ExamRequest < ApplicationRecord
  belongs_to :student
  belongs_to :exam_period
  
  has_many :exam_request_subjects, dependent: :destroy
  has_many :subjects, through: :exam_request_subjects
end
