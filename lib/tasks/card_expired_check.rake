namespace :card_expired_check do
  desc '登録したクレジットカードの中で、有効期限が間近のユーザーに通知メールを送る'
  task credit_card_expired_check: :environment do

    # 本番では削除
    puts "タスクのテストです。" # 本番では削除
    user = User.find(2) # 本番では削除 Userモデルを参照する
    puts user # 本番では削除
    user.email = 'p.aaattt25@gmail.com' # 本番では削除
    puts user.email # 本番では削除
    UserMailer.card_expired_mail(user).deliver # 本番では削除

    # 本番で使用

    # users = User.all # 本番ではクレジットカード有効期限が間近のuserを取ってくる
    # if users != nil
    #   users.each do |user|
    #     UserMailer.card_expired_mail(user).deliver
    #   end
    # end
  end
end
