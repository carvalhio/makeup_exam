class CreateTestApplicationSchoolClasses < ActiveRecord::Migration[7.2]
  def change
    create_table :test_application_school_classes do |t|
      t.references :test_application, null: false, foreign_key: true
      t.references :school_class, null: false, foreign_key: true

      t.timestamps
    end

    add_index :test_application_school_classes,
              [ :test_application_id, :school_class_id ],
              unique: true,
              name: "index_test_applications_on_application_and_class"
  end
end
