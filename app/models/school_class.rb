class SchoolClass < ApplicationRecord
  has_many :students, dependent: :destroy

  validates :grade, presence: true
  validates :identifier, presence: true
  validates :shift, presence: true

  validates :identifier, uniqueness: {
    scope: [:grade, :shift],
    message: "já existe para essa série e turno"
  }
end