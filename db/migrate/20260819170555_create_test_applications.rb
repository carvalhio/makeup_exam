class CreateTestApplications < ActiveRecord::Migration[7.2]
  def change
    create_table :test_applications do |t|
      t.string :exam_type, null: false
      t.date :application_date, null: false
      t.string :subject_name, null: false
      t.string :invigilator

      t.timestamps
    end
  end
end
