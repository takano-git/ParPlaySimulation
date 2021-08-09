class Club < ApplicationRecord
  belongs_to :user, optional: true

  VALID_YARN_COUNT_STRING_REGEX = /\A[A-Z]+\z/
  # 振動数は３桁の半角数字
  VALID_FREQUENCY_REGEX = /\d+\d+\d/
  validates :largo, :weight, presence: true
  validates :yarn_count_string, presence: true, format: { with: VALID_YARN_COUNT_STRING_REGEX }
  validates :frequency, format: { with: VALID_FREQUENCY_REGEX }, allow_nil: true
end
