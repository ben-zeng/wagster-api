class CreateMatch < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.belongs_to :matched_user, null: false
      t.timestamps
    end
  end
end
