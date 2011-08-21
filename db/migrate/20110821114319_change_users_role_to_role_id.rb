class ChangeUsersRoleToRoleId < ActiveRecord::Migration
  def up
    rename_column :users, :role, :role_id
    change_column :users, :role_id, :integer
  end

  def down
    rename_column :users, :role_id, :role
    change_column :users, :role, :string
  end
end
