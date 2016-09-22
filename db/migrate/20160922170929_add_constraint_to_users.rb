class AddConstraintToUsers < ActiveRecord::Migration[5.0]
  def up
    change_column :users, :email, :string, unique: true
  end

  def down
    change_column :users, :email, :string, unique: false
  end
end
