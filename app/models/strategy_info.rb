class StrategyInfo < ApplicationRecord
  belongs_to :user
  belongs_to :golfclub
  belongs_to :course
  belongs_to :hole

  has_one_attached :photo
  enum shot_id: { "tee": 0, "2nd": 1, "3rd": 2, "green": 3 }
  enum location_name: { "R": 0, "B": 1, "L": 2 }

  validates :comment, presence: true, length: { maximum: 200 }
  validates :photo, content_type: { in: [:png, :jpg, :ipeg], message: 'のファイル形式が違います' },
                    size: { less_than_or_equal_to: 10.megabytes, message: 'の容量は10MB以内にしてください' }

end
