class AddSameShiftToExamRequests < ActiveRecord::Migration[7.1]
  def change
    add_column :exam_requests, :same_shift, :boolean, default: false, null: false
  end
end
