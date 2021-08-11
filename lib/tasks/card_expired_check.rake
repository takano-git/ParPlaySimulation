namespace :card_expired_check do
  desc '登録したクレジットカードの中で、有効期限が間近のユーザーに通知メールを送る'
  task credit_card_expired_check: :environment do

    # 今日が月初かどうかのチェック
    beginning_of_month = Date.today.at_beginning_of_month # 月初の日付
    today = Date.today # 今日の日付
    
    puts beginning_of_month # 月初の日付を出力
    puts today # 今日の日付を出力

    # 「今日は月初の日付と同じか?」
    puts today.eql?(beginning_of_month)
    
    if Date.today.eql?(beginning_of_month)
      puts '今日は月初です。カード有効期限が今月のユーザーに通知メールを送ります。'  
    else
      puts '今日は月初ではありませんので、カード有効期限が今月のユーザーへメール送信はありません。'
    end

    # 本番では削除
    # puts "タスクのテストです。" # 本番では削除
    # user = User.find(2) # 本番では削除 Userモデルを参照する
    # puts user # 本番では削除
    # user.email = 'p.aaattt25@gmail.com' # 本番では削除
    # puts user.email # 本番では削除
    # UserMailer.card_expired_mail(user).deliver # 本番では削除

    # 本番で使用
    puts "タスクを始めます。"
    users = User.joins(:cards).where(cards: {default_card: true, exp_month: Date.current.mon, exp_year: Date.current.year })
    if users != nil
      users.each do |user|
        UserMailer.card_expired_mail(user).deliver
      end
        puts "クレジットカードの有効期限が今年かつ今月のユーザーにメールを送りました。"
      else
        puts "クレジットカードの有効期限が今年かつ今月のユーザーはいません。"
    end

  end
end
