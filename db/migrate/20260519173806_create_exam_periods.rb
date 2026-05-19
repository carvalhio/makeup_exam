class CreateExamPeriods < ActiveRecord::Migration[7.2]
  def change
    create_table :exam_periods do |t|
      t.string :stage
      t.string :exam_type

      t.timestamps
    end
  end
end
