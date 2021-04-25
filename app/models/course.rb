class Course < ApplicationRecord
  has_many :holes, dependent: :destroy
  belongs_to :golfclub

  validates :name, presence: true, length: { maximum: 50 }
end
