class Subject < ApplicationRecord
	has_many :exam_request_subjects, dependent: :destroy
	has_many :exam_requests, through: :exam_request_subjects
end 