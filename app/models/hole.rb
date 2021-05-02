class Hole < ApplicationRecord
  belongs_to :course

  validates :hole_number, presence: true
  validates :number_of_pars, presence: true
end
