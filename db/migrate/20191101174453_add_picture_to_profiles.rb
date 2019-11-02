class AddPictureToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :picture, :string
  end
end
