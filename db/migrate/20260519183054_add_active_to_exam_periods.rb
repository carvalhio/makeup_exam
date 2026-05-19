class AddActiveToExamPeriods < ActiveRecord::Migration[7.2]
  def change
    add_column :exam_periods, :active, :boolean
  end
end
