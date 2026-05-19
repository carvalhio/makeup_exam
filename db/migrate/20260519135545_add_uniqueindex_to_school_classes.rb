class AddUniqueIndexToSchoolClasses < ActiveRecord::Migration[8.0]
  def change
    add_index :school_classes,
              [:grade, :identifier, :shift],
              unique: true,
              name: "index_unique_school_classes"
  end
end