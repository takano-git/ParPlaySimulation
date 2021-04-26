class Area < ApplicationRecord
  validates :prefecture, presence: true, length: { maximum: 30 }
  validates :district, presence: true, length: { maximum: 30 }
end
