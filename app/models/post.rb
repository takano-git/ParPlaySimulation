class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :golfclub
  has_one_attached :photo

  validates :title, presence: true, length: { maximum: 50 }
  validates :comment, presence: true, length: { maximum: 300 }
end
