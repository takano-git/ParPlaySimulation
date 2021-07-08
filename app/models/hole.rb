class Hole < ApplicationRecord
  has_many :strategy_infos
  belongs_to :golfclub
  belongs_to :course

  has_one_attached :map_r
  has_one_attached :map_b
  has_one_attached :map_l

  validates :hole_number, presence: true
  validates :number_of_pars, presence: true
end
