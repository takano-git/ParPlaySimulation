class Golfclub < ApplicationRecord
  belongs_to :area
  has_many :courses, dependent: :destroy
  has_many :holes, through: :courses, dependent: :destroy
  has_one_attached :photo
  
  VALID_URL_REGEX = /https?:\/\/[\w\/:%#\$&\?\(\)~\.=\+\-]+|\A\z/
  VALID_VIDEO_REGEX = /\A(https\:\/\/)?(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)+[\S]{11}\z/

  validates :name, presence: true, length: { maximum: 50 }
  validates :home_page_url, format: { with: VALID_URL_REGEX }
  validates :strategy_video, format: { with: VALID_VIDEO_REGEX }, allow_blank: true
  validates :photo, content_type: { in: [:png, :jpg, :ipeg], message: 'のファイル形式が違います' },
                    size: { less_than_or_equal_to: 10.megabytes, message: 'の容量は10MB以内にしてください' }
end
