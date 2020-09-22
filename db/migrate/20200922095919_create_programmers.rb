class CreateProgrammers < ActiveRecord::Migration[6.0]
  def change
    create_table :programmers do |t|
      t.string :username
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.datetime :last_login
      t.boolean :is_project_manager

      t.timestamps
    end
  end
end
