class TestApplication < ApplicationRecord
  has_many :test_application_school_classes, dependent: :destroy
  has_many :school_classes, through: :test_application_school_classes

  validates :exam_type, presence: true
  validates :application_date, presence: true
  validates :subject_name, presence: true
end
