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
Area.create( prefecture: '青森県', district: "東北" )
Area.create( prefecture: '岩手県', district: "東北" )
Area.create( prefecture: '宮城県', district: "東北" )
Area.create( prefecture: '秋田県', district: "東北" )
Area.create( prefecture: '山形県', district: "東北" )
Area.create( prefecture: '福島県', district: "東北" )
Area.create( prefecture: '茨城県', district: "関東・甲信越" )
Area.create( prefecture: '栃木県', district: "関東・甲信越" )
Area.create( prefecture: '群馬県', district: "関東・甲信越" )
Area.create( prefecture: '埼玉県', district: "関東・甲信越" )
Area.create( prefecture: '千葉県', district: "関東・甲信越" )
Area.create( prefecture: '東京都', district: "関東・甲信越" )
Area.create( prefecture: '神奈川県', district: "関東・甲信越" )
Area.create( prefecture: '山梨県', district: "関東・甲信越" )
Area.create( prefecture: '長野県', district: "関東・甲信越" )
Area.create( prefecture: '新潟県', district: "関東・甲信越" )
Area.create( prefecture: '富山県', district: "東海・北陸" )
Area.create( prefecture: '石川県', district: "東海・北陸" )
Area.create( prefecture: '福井県', district: "東海・北陸" )
Area.create( prefecture: '岐阜県', district: "東海・北陸" )
Area.create( prefecture: '静岡県', district: "東海・北陸" )
Area.create( prefecture: '愛知県', district: "東海・北陸" )
Area.create( prefecture: '三重県', district: "東海・北陸" )
Area.create( prefecture: '滋賀県', district: "関西" )
Area.create( prefecture: '京都府', district: "関西" )
Area.create( prefecture: '大阪府', district: "関西" )
Area.create( prefecture: '兵庫県', district: "関西" )
Area.create( prefecture: '奈良県', district: "関西" )
Area.create( prefecture: '和歌山県', district: "関西" )
Area.create( prefecture: '鳥取県', district: "中国" )
Area.create( prefecture: '島根県', district: "中国" )
Area.create( prefecture: '岡山県', district: "中国" )
Area.create( prefecture: '広島県', district: "中国" )
Area.create( prefecture: '山口県', district: "中国" )
Area.create( prefecture: '徳島県', district: "四国" )
Area.create( prefecture: '香川県', district: "四国" )
Area.create( prefecture: '愛媛県', district: "四国" )
Area.create( prefecture: '高知県', district: "四国" )
Area.create( prefecture: '福岡県', district: "九州・沖縄" )
Area.create( prefecture: '佐賀県', district: "九州・沖縄" )
Area.create( prefecture: '長崎県', district: "九州・沖縄" )
Area.create( prefecture: '熊本県', district: "九州・沖縄" )
Area.create( prefecture: '大分県', district: "九州・沖縄" )
Area.create( prefecture: '宮崎県', district: "九州・沖縄" )
Area.create( prefecture: '鹿児島県', district: "九州・沖縄" )
Area.create( prefecture: '沖縄県', district: "九州・沖縄" )

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
hamano_map = [["hamano_h1_map.png", "hm1"], ["hamano_h2_map.png", "hm2"]]
hamano_map_b = ["hamano_h1_map_b.png", "hm1b"]
hamano_map_l = ["hamano_h1_map_l.png", "hm1l"]
susono_map = [["susono_h1_map.png", "sm1"], ["susono_h2_map.png", "sm2"]]

hole = Hole.where(golfclub_id: 1).first
hole.map_r.attach(io: File.open("./public/hole_maps/hamano_h1_map.png"), filename: "hamano_h1_map.png")
hole.map_b.attach(io: File.open("./public/hole_maps/hamano_h1_map_b.png"), filename: "hamano_h1_map_b.png")
hole.map_l.attach(io: File.open("./public/hole_maps/hamano_h1_map_l.png"), filename: "hamano_h1_map_l.png")
hole.save
hole = Hole.where(golfclub_id: 1).where(id: 2)[0]
hole.map_r.attach(io: File.open("./public/hole_maps/hamano_h2_map.png"), filename: "hamano_h2_map.png")
hole.save

hole = Hole.where(golfclub_id: 2).first
hole.map_r.attach(io: File.open("./public/hole_maps/susono_h2_map.png"), filename: "susono_h2_map.png")
hole.save

puts "ホール作成！"

# 攻略情報データ作成
hamano_array = []
3.times do |i|
  n = i + 1
  hamano_array.push(
                   ["hamano_h#{n}_tee.jpg",  "h_h#{n}_s1"],
                   ["hamano_h#{n}_2nd.jpg",   "h_h#{n}_s2"], 
                   ["hamano_h#{n}_3rd.jpg",   "h_h#{n}_s3"], 
                   ["hamano_h#{n}_green.jpg", "h_h#{n}_sg"]
                    )
end
susono_array = [
                 ["susono_h1_tee.jpg", "s_h1_s1"], 
                 ["susono_h1_2nd.jpg", "s_h1_s2"],
                 ["susono_h1_green_1.jpg", "s_h1_sg_1"],
                 ["susono_h1_green_2.jpg", "s_h1_sg_2"],
                 ["susono_h2_tee.jpg", "s_h2_s1"], 
                 ["susono_h2_2nd.jpg", "s_h2_s2"],
                 ["susono_h2_3rd.jpg", "s_h2_s3"],
                 ["susono_h2_green.jpg", "s_h2_sg"]
               ]

2.times do |i|
  array = hamano_array
  n = i + 1
  4.times do |l|
    h = l + 1
    strategy_info = StrategyInfo.new
    strategy_info.golfclub_id = 1
    strategy_info.course_id = 1
    strategy_info.hole_id = n
    strategy_info.shot_id = h
    strategy_info.user_id = 1
    strategy_info.location_name = "R"
    strategy_info.photo.attach(
      io: File.open("./public/strategy_infos/#{array[l][0]}"),
      filename: "#{array[l][1]}")
    strategy_info.comment = "コメント#{h}"
    strategy_info.save
  end

end

susono_array.each_with_index do |array, i|
  n = i + 1
  strategy_info = StrategyInfo.new
  strategy_info.golfclub_id = 2
  strategy_info.course_id = 2
  strategy_info.hole_id = 1 if i < 5
  strategy_info.hole_id = 2 if i >= 5
  strategy_info.shot_id = n
  strategy_info.user_id = 1
  strategy_info.location_name = "R"
  strategy_info.photo.attach(
    io: File.open("./public/strategy_infos/#{array[0]}"),
    filename: "#{array[1]}")
  strategy_info.comment = "susonoコメント#{n}"
  strategy_info.save
end

puts "攻略情報作成！"