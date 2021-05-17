# ユーザーサンプルデーター作成

User.create!(name: "管理者",
  nickname: "カンリシャ",
  membership_number: "A000000",
  email: "admin@gmail.com",
  password: "password",
  password_confirmation: "password",
  phone_number: "012-0000-0000",
  flying_distance: 240,
  admin: true)

puts "管理者作成！"

9.times do |i|
n = i + 1 
name_number = n.to_s.tr('0-9a-zA-Z','０-９ａ-ｚＡ-Ｚ')
User.create!(name: "会員#{name_number}",
    nickname: "カイイン#{n}",
    membership_number: "A00000#{n}",
    email: "sample#{n}@gmail.com",
    password: "password#{n}",
    phone_number: "012-1234-5678",
    flying_distance: 260,
    password_confirmation: "password#{n}")
end

puts "会員作成！"

# 地域データ作成

Area.create( prefecture: '北海道', district: "北海道" )
Area.create( prefecture: '青森県', district: "北東北" )
Area.create( prefecture: '岩手県', district: "北東北" )
Area.create( prefecture: '秋田県', district: "北東北" )
Area.create( prefecture: '宮城県', district: "南東北" )
Area.create( prefecture: '山形県', district: "南東北" )
Area.create( prefecture: '福島県', district: "南東北" )
Area.create( prefecture: '茨城県', district: "北関東" )
Area.create( prefecture: '栃木県', district: "北関東" )
Area.create( prefecture: '群馬県', district: "北関東" )
Area.create( prefecture: '埼玉県', district: "南関東" )
Area.create( prefecture: '千葉県', district: "南関東" )
Area.create( prefecture: '東京都', district: "南関東" )
Area.create( prefecture: '神奈川県', district: "南関東" )
Area.create( prefecture: '山梨県', district: "甲信越" )
Area.create( prefecture: '長野県', district: "甲信越" )
Area.create( prefecture: '新潟県', district: "甲信越" )
Area.create( prefecture: '富山県', district: "北陸" )
Area.create( prefecture: '石川県', district: "北陸" )
Area.create( prefecture: '福井県', district: "北陸" )
Area.create( prefecture: '静岡県', district: "中部" )
Area.create( prefecture: '愛知県', district: "中部" )
Area.create( prefecture: '岐阜県', district: "中部" )
Area.create( prefecture: '三重県', district: "中部" )
Area.create( prefecture: '滋賀県', district: "近畿" )
Area.create( prefecture: '京都府', district: "近畿" )
Area.create( prefecture: '大阪府', district: "近畿" )
Area.create( prefecture: '兵庫県', district: "近畿" )
Area.create( prefecture: '奈良県', district: "近畿" )
Area.create( prefecture: '和歌山県', district: "近畿" )
Area.create( prefecture: '鳥取県', district: "中国" )
Area.create( prefecture: '島根県', district: "中国" )
Area.create( prefecture: '岡山県', district: "中国" )
Area.create( prefecture: '広島県', district: "中国" )
Area.create( prefecture: '山口県', district: "中国" )
Area.create( prefecture: '徳島県', district: "四国" )
Area.create( prefecture: '香川県', district: "四国" )
Area.create( prefecture: '愛媛県', district: "四国" )
Area.create( prefecture: '高知県', district: "四国" )
Area.create( prefecture: '福岡県', district: "北部九州" )
Area.create( prefecture: '佐賀県', district: "北部九州" )
Area.create( prefecture: '長崎県', district: "北部九州" )
Area.create( prefecture: '熊本県', district: "北部九州" )
Area.create( prefecture: '大分県', district: "北部九州" )
Area.create( prefecture: '宮崎県', district: "南九州・沖縄" )
Area.create( prefecture: '鹿児島県', district: "南九州・沖縄" )
Area.create( prefecture: '沖縄県', district: "南九州・沖縄" )

puts "地域作成！"

# ゴルフ場データ作成

5.times do |i|
  n = i + 1
  Golfclub.create!(
    name: "サンプルカントリー#{n}",
    home_page_url: "https://www.google.com",
    strategy_video: "https://youtu.be/KgFxOBZZFhc",
    area_id: rand(1..47)
  )
end

puts "ゴルフ場作成！"

# コースデータ作成

golfclubs = Golfclub.order(:id)
golfclubs.each { |golfclub| golfclub.courses.create!([ { name: "OUT" }, { name: "IN" } ]) }

puts "コース作成！"

# ホールデータ作成
courses = Course.order(:id)

courses.each do |course|
  n = 0
  n = 9 if course.name == "IN"
  course.holes.create!(
    [
      { hole_number: 1 + n, number_of_pars: rand(3..7), golfclub_id: course.golfclub_id },
      { hole_number: 2 + n, number_of_pars: rand(3..7), golfclub_id: course.golfclub_id },
      { hole_number: 3 + n, number_of_pars: rand(3..7), golfclub_id: course.golfclub_id },
      { hole_number: 4 + n, number_of_pars: rand(3..7), golfclub_id: course.golfclub_id },
      { hole_number: 5 + n, number_of_pars: rand(3..7), golfclub_id: course.golfclub_id },
      { hole_number: 6 + n, number_of_pars: rand(3..7), golfclub_id: course.golfclub_id },
      { hole_number: 7 + n, number_of_pars: rand(3..7), golfclub_id: course.golfclub_id },
      { hole_number: 8 + n, number_of_pars: rand(3..7), golfclub_id: course.golfclub_id },
      { hole_number: 9 + n, number_of_pars: rand(3..7), golfclub_id: course.golfclub_id }
    ]
  )
end

puts "ホール作成！"
