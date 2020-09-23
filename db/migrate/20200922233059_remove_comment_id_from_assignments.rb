class RemoveCommentIdFromAssignments < ActiveRecord::Migration[6.0]
  def change
    remove_column :assignments, :comment_id, :integer
  end
end
