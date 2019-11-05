class CreateProfileMatch < ActiveRecord::Migration[6.0]
  def change
    create_table :profile_matches do |t|
      t.references :user, null: false
      t.references :friend, null: false
      t.timestamps
    end
  end
end
