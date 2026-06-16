class AddYearToExamPeriods < ActiveRecord::Migration[7.2]
  def change
    add_column :exam_periods, :year, :integer
  end
end
