class Profile < ApplicationRecord
    belongs_to :user
    mount_uploder :picture, PictureUploader
end
