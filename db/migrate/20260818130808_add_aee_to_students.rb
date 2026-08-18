class AddAeeToStudents < ActiveRecord::Migration[7.2]
  def change
    add_column :students, :aee, :boolean, default: false, null: false
  end
end
