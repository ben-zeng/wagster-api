class AddPictureUrlToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :picture_url, :string
  end
end
