class CreateExamRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :exam_requests do |t|
      t.references :student, null: false, foreign_key: true
      t.date :exam_date
      t.string :status

      t.timestamps
    end
  end
end
