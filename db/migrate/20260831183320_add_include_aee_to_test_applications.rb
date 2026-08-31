class AddIncludeAeeToTestApplications < ActiveRecord::Migration[7.2]
  def change
    add_column :test_applications, :include_aee, :boolean, default: true, null: false
  end
end
