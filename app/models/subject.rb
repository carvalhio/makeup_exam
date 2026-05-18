class Subject < ApplicationRecord
	has_many :exam_request_subjects, dependent: :destroy
end has_many :exam_requests, through: :exam_request_subjects
