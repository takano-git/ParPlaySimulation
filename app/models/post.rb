class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :golfclub
  has_one_attached :photo

  validates :title, presence: true, length: { maximum: 50 }
  validates :comment, presence: true, length: { maximum: 250 }
  validates :photo, content_type: { in: [:png, :jpg, :ipeg], message: 'のファイル形式が違います' },
                    size: { less_than_or_equal_to: 10.megabytes, message: 'の容量は10MB以内にしてください' }
end
