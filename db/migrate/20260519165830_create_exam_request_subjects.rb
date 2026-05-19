class CreateExamRequestSubjects < ActiveRecord::Migration[7.2]
  def change
    create_table :exam_request_subjects do |t|
      t.references :exam_request, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true

      t.timestamps
    end
  end
end