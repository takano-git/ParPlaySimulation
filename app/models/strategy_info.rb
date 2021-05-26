class StrategyInfo < ApplicationRecord
  belongs_to :hole

  has_one_attached :photo
end
