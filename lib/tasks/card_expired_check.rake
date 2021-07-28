namespace :card_expired_check do
  desc '登録したクレジットカードの中で、有効期限が間近のユーザーに通知メールを送る'
  task credit_card_expired_check: :environment do
    puts "タスクのテストです。"
    user = User.find(2) #Userモデルを参照する！
    puts user
    user.email = 'p.aaattt25@gmail.com'
    puts user.email
    # UserMailer.with(user: @user).card_expired_mail.deliver_now
    UserMailer.card_expired_mail(user).deliver
  end
end
