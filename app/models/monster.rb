class Monster < ApplicationRecord
  has_many :user_monsters
  has_many :monster, through: :user_monsters
  #has_one_attached :image　carrierwaveを使用したためコメントアウト
  #1つのモンスター画像と紐づく
  mount_uploader :image, MonsterImageUploader #carrierwaveを使用
end
