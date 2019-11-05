class CreateMatch < ActiveRecord::Migration[6.0]
  def change
    create_table :match_pair do |t|
      t.belongs_to :profile, foreign_key: true, null: false
      t.belongs_to :match, null: false
      t.timestamps
    end
  end
end
