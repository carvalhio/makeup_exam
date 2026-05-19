class ExamPeriod < ApplicationRecord
  has_many :exam_requests, dependent: :destroy

  def self.current
    find_by(active: true)
  end
end