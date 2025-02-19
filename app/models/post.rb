class Post < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 150}
  #文字数０は認めない、151文字以上も認めない
end
