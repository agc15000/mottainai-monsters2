class Monster < ApplicationRecord
  has_many :user_monsters
  has_many :monster, through: :user_monsters
end
