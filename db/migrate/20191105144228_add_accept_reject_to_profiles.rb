class AddAcceptRejectToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :accepted_profiles, :text, array: true, default: []
    add_column :profiles, :rejected_profiles, :text, array: true, default: []
  end
end
