class Club < ApplicationRecord
  belongs_to :user

  validates :yarn_count_string, :largo, :weight, presence: true
end
