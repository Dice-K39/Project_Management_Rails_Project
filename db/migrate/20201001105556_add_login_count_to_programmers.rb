class AddLoginCountToProgrammers < ActiveRecord::Migration[6.0]
  def change
    add_column :programmers, :login_count, :integer
  end
end
