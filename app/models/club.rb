class Club < ApplicationRecord
  MAX_SELECT_COUNT = 15 # クラブセッティングは一人14本まで(15本目から不可)
  belongs_to :user, optional: true

  VALID_YARN_COUNT_STRING_REGEX = /\A[A-Z]+\z/
  # 振動数は３桁の半角数字
  VALID_FREQUENCY_REGEX = /\d+\d+\d/
  validates :largo, :weight, presence: true
  validates :yarn_count_string, presence: true, format: { with: VALID_YARN_COUNT_STRING_REGEX }
  validates :frequency, format: { with: VALID_FREQUENCY_REGEX }, allow_nil: true
  # validate :select_count_must_be_within_limit

  private
  # クラブセッティングは一人14本まで（15本目から不可）
  def select_count_must_be_within_limit
    errors.add(:selected, "クラブセッティングは14本までです。") if user.clubs.where(selected: true).count >= MAX_SELECT_COUNT
  end

end
