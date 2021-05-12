class Course < ApplicationRecord
  has_many :holes, dependent: :destroy
  accepts_nested_attributes_for :holes, allow_destroy: true
  belongs_to :golfclub

  validates :name, presence: true, length: { maximum: 50 }
end
