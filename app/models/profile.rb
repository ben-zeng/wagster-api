class Profile < ApplicationRecord
    belongs_to :user
    mount_base64_uploader :picture, PictureUploader

    has_many :match_pairs, dependent: :destroy
    has_many :matches, through: :match_pairs
end
