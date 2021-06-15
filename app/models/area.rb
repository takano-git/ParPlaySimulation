class Area < ApplicationRecord
  has_many :golfclubs, dependent: :destroy
  
  validates :prefecture, presence: true, length: { maximum: 30 }
  validates :district, presence: true, length: { maximum: 30 }
end
