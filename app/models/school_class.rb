class SchoolClass < ApplicationRecord
  has_many :students, dependent: :destroy

  has_many :test_application_school_classes, dependent: :destroy
  has_many :test_applications, through: :test_application_school_classes

  validates :grade, presence: true
  validates :identifier, presence: true
  validates :shift, presence: true

  validates :identifier, uniqueness: {
    scope: [ :grade, :shift ],
    message: "já existe para essa série e turno"
  }

  def full_name
    "#{grade} #{identifier} - #{shift}"
  end
end
