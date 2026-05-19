class AddExamPeriodToExamRequests < ActiveRecord::Migration[7.2]
  def change
        add_reference :exam_requests, :exam_period, foreign_key: true
  end
end
