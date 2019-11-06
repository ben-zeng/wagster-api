class MatchPair < ApplicationRecord
  belongs_to :profile
  belongs_to :match, class_name: "Profile"
end
