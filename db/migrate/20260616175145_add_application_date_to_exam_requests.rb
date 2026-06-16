class AddApplicationDateToExamRequests < ActiveRecord::Migration[7.2]
  def change
    add_column :exam_requests, :application_date, :date
  end
end
