class Match_Pair < ApplicationRecord
  belongs_to :profile
  belongs_to :match, class_name: "profile"
end
