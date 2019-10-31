class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :dog_name
      t.text :biography
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
