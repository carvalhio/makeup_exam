class CreateSchoolClasses < ActiveRecord::Migration[7.2]
  def change
    create_table :school_classes do |t|
      t.string :grade
      t.string :identifier
      t.string :shift

      t.timestamps
    end
  end
end
