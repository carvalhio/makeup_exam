class Student < ApplicationRecord
  belongs_to :school_class

  has_many :exam_requests, dependent: :destroy
end
