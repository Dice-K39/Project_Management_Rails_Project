class CreateAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :assignments do |t|
      t.text :task
      t.datetime :assigned_at
      t.integer :programmer_id
      t.integer :project_id
      t.integer :comment_id

      t.timestamps
    end
  end
end
