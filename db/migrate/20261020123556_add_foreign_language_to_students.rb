class AddForeignLanguageToStudents < ActiveRecord::Migration[7.2]
  def change
    add_column :students, :foreign_language, :string
  end
end
