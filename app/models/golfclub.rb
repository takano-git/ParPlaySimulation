class Golfclub < ApplicationRecord
  has_many :courses, dependent: :destroy
  
  VALID_URL_REGEX = /https?:\/\/[\w\/:%#\$&\?\(\)~\.=\+\-]+|\A\z/
  VALID_VIDEO_REGEX = /\A(https\:\/\/)?(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)+[\S]{11}\z/

  validates :name, presence: true, length: { maximum: 50 }
  validates :district, presence: true, length: { maximum: 50 }
  validates :home_page_url, format: { with: VALID_URL_REGEX }
  validates :strategy_video, format: { with: VALID_VIDEO_REGEX }
end
