class UpdateExamRequestFields < ActiveRecord::Migration[7.2]
  def change
    remove_column :exam_requests, :exam_date, :date
    remove_column :exam_requests, :status, :string

    add_column :exam_requests, :reason, :string
    add_column :exam_requests, :reason_description, :text
  end
end