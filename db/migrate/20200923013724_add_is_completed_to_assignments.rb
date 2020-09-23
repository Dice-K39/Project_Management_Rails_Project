class AddIsCompletedToAssignments < ActiveRecord::Migration[6.0]
  def change
    add_column :assignments, :is_completed, :boolean
  end
end
