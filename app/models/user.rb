class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :user_monsters
  has_many :monsters, through: :user_monsters
  has_many :conversations
  has_many :monster_messages, through: :conversations

end
