class Club < ApplicationRecord
  belongs_to :user, optional: true

  VALID_YARN_COUNT_STRING_REGEX = /\A[A-Z]+\z/
  # 振動数は３桁の半角数字
  VALID_FREQUENCY_REGEX = /\d+\d+\d/
  validates :largo, :weight, presence: true
  validates :yarn_count_string, presence: true, format: { with: VALID_YARN_COUNT_STRING_REGEX }
  validates :frequency, format: { with: VALID_FREQUENCY_REGEX }
  # validate :limit_club_setting
  # validate :limit_same_club_setting

  # ゴルフクラブセッティングは最大14本まで
  # def limit_club_setting
  #   errors.add(:club, "クラブセッティングは14本までです。") if user && user.clubs.where(selected: true).count > 14
  # end

  # def limit_same_club_setting
  #   errors.add(:club, "同じゴルフクラブをクラブセッティングできません。") if self.selected == true
  # end

end
