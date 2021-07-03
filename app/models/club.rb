class Club < ApplicationRecord
  belongs_to :user

  validates :yarn_count_string, :largo, :weight, presence: true
  VALID_YARN_COUNT_STRING_REGEX = /\A[A-Z]+\z/
  # 振動数は３桁の半角数字
  VALID_FREQUENCY_REGEX = /\d+\d+\d/
  
  validates :yarn_count_string, format: { with: VALID_YARN_COUNT_STRING_REGEX }
  validates :frequency, format: { with: VALID_FREQUENCY_REGEX }


    # ゴルフクラブセッティングは最大14本まで
    validate :limit_club_setting
  
  def limit_club_setting
    errors.add(:club, "クラブセッティングは14本までです。") if user && user.clubs.where(selected: true).count > 14
  end

end
