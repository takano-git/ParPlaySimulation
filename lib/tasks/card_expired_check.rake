namespace :card_expired_check do
  desc '登録したクレジットカードの中で、有効期限が間近のユーザーに通知メールを送る'
  task credit_card_expired_check: :environment do
    puts "タスクのテストです。"
    puts User.find(2).name #Userモデルを参照する！
  end
end
