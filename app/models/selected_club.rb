class SelectedClub < ApplicationRecord
  belongs_to :user
  validates :club_id, uniqueness: true
end
