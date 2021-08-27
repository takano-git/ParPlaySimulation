class Course < ApplicationRecord
  belongs_to :golfclub
  has_many :holes, dependent: :destroy
  has_many :strategy_infos, dependent: :destroy
  accepts_nested_attributes_for :holes, allow_destroy: true

  validates :name, presence: true, length: { maximum: 30 }
end
