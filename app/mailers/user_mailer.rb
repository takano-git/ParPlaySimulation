class UserMailer < ApplicationMailer
  default from: 'perplaysimulation@gmail.com'

  # 登録クレジットカード有効期限間近のお知らせメール
  def card_expired_mail(user)
    @user = user
    @url  = 'https://perplaysimulation/login'
    mail(to: @user.email, subject: 'ご登録クレジットカード有効期限に関するご案内')
  end
end
