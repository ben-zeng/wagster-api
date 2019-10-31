class AddUserIdToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :user_id, :string
    add_index :profiles, :user_id
  end
end
