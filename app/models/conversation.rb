class Conversation < ApplicationRecord
  belongs_to :user
  belongs_to :user_monster
  has_many :monster_messages, dependent: :destroy
end
