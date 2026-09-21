class AddStageToTestApplications < ActiveRecord::Migration[7.2]
  def change
    add_column :test_applications, :stage, :string
  end
end
