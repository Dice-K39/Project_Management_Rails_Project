class AddAssignmentIdToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :assignment_id, :integer
  end
end
