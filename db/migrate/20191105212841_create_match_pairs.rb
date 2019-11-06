class CreateMatchPairs < ActiveRecord::Migration[6.0]
  def change
    create_table :match_pairs do |t|
      t.belongs_to :profile, foreign_key: true
      t.belongs_to :match
      t.timestamps
    end
  end
end
