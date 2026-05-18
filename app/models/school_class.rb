class SchoolClass < ApplicationRecord
	has_many :student, dependent: :destroy
end
