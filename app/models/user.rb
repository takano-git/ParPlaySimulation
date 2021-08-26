class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :clubs, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :strategy_infos, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  # validates :name, presence: true
  validates :membership_number, length: { maximum: 5 }
         
protected

# SNSログイン
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    if data['nickname'].nil?
      unless user
          user = User.create(
            name: data['name'],
            email: data['email'],
            password: Devise.friendly_token[0,20]
          )
      end
    else
      unless user
        user = User.create(
          name: data['name'],
          nickname: data['nickname'],
          email: data['email'],
          password: Devise.friendly_token[0,20]
        )
      end
    end
    user
  end

end
