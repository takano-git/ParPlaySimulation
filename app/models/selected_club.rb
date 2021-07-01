class SelectedClub < ApplicationRecord
  belongs_to :user
  validates :club_id, uniqueness: true
  
  # メインゴルフクラブの登録は最大14本まで
  validate :limit_selected_club_register_count, on: :create
  
  def limit_selected_club_register_count
    errors.add(:selected_club, "登録できるメインゴルフクラブは14本です。") if user && user.selected_clubs.count > 14
  end
end
