class StrategyInfo < ApplicationRecord
  belongs_to :hole

  has_one_attached :photo
  # enum shot_id: { tee: 0, second: 1, third: 2, green: 3 }, _prefix: true
  enum shot_id: { "tee": 0, "2nd": 1, "3rd": 2, "green": 3 }
  enum location_name: { "R": 0, "B": 1, "L": 2 }

  validates :comment, presence: true, length: { maximum: 80 }
  validates :photo, content_type: { in: [:png, :jpg, :ipeg], message: 'のファイル形式が違います' },
                    size: { less_than_or_equal_to: 10.megabytes, message: 'の容量は10MB以内にしてください' }
#  :location_name,
# :photo_target_x, :photo_target_y, :photo_point_x, :photo_point_y, :photo_size_x, :photo_size_y,
# :map_target_x, :map_target_y, :map_point_x, :map_point_y, :map_shoot_x, :map_shoot_y, :map_size_x, :map_size_y
end
