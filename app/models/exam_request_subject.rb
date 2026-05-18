class ExamRequestSubject < ApplicationRecord
  belongs_to :exam_request
  belongs_to :subject
end
