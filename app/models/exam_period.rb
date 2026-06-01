class ExamPeriod < ApplicationRecord
  has_many :exam_requests, dependent: :destroy

  def self.current
    find_by(active: true)
  end

  def name
    "#{stage} - #{exam_type}"
  end
end
