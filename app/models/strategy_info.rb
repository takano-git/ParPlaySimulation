class StrategyInfo < ApplicationRecord
  belongs_to :hole

  has_one_attached :photo
  # enum shot_id: { tee: 0, second: 1, third: 2, green: 3 }, _prefix: true
  enum shot_id: { "tee": 0, "2nd": 1, "3rd": 2, "green": 3 }
end
