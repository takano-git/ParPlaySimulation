class UserMailer < ApplicationMailer
  default from: 'parplaysimulation@gmail.com'

  # 登録クレジットカード有効期限間近のお知らせメール
  def card_expired_mail(user)
    @user = user
    # @url  = 'https://perplaysimulation/users/sign_in' # 本番環境で正しいURL入れる
    @url  = 'https://obscure-oasis-47387.herokuapp.com/users/sign_in' # 本番で消す

    mail(to: @user.email, subject: 'ご登録クレジットカード有効期限に関するご案内')
  end
end
