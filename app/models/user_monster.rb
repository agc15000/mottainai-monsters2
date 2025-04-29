class UserMonster < ApplicationRecord
  belongs_to :user
  belongs_to :monster
  has_many :conversations
end
