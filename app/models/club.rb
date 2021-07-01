class Club < ApplicationRecord
  belongs_to :user

  validates :yarn_count_string, :largo, :weight, presence: true
  VALID_CLUB_REGEX = /\A[A-Z]+\z/
  validates :yarn_count_string, format: { with: VALID_CLUB_REGEX }
end
