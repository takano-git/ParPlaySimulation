
# ユーザーサンプルデーター作成

User.create!(name: "管理者",
  nickname: "えぐさん",
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

Area.create(prefecture: '北海道', district: "北海道")
Area.create(prefecture: '青森県', district: "東北（北）")
Area.create(prefecture: '岩手県', district: "東北（北）")
Area.create(prefecture: '秋田県', district: "東北（北）")
Area.create(prefecture: '宮城県', district: "東北（南）")
Area.create(prefecture: '山形県', district: "東北（南）")
Area.create(prefecture: '福島県', district: "東北（南）")
Area.create(prefecture: '茨城県', district: "関東（北）")
Area.create(prefecture: '栃木県', district: "関東（北）")
Area.create(prefecture: '群馬県', district: "関東（北）")
Area.create(prefecture: '埼玉県', district: "関東（北）")
Area.create(prefecture: '千葉県', district: "関東（南）")
Area.create(prefecture: '東京都', district: "関東（南）")
Area.create(prefecture: '神奈川県', district: "関東（南）")
Area.create(prefecture: '山梨県', district: "甲信越")
Area.create(prefecture: '長野県', district: "甲信越")
Area.create(prefecture: '新潟県', district: "甲信越")
Area.create(prefecture: '富山県', district: "北陸")
Area.create(prefecture: '石川県', district: "北陸")
Area.create(prefecture: '福井県', district: "北陸")
Area.create(prefecture: '静岡県', district: "中部")
Area.create(prefecture: '愛知県', district: "中部")
Area.create(prefecture: '岐阜県', district: "中部")
Area.create(prefecture: '三重県', district: "中部")
Area.create(prefecture: '滋賀県', district: "近畿")
Area.create(prefecture: '京都府', district: "近畿")
Area.create(prefecture: '大阪府', district: "近畿")
Area.create(prefecture: '兵庫県', district: "近畿")
Area.create(prefecture: '奈良県', district: "近畿")
Area.create(prefecture: '和歌山県', district: "近畿")
Area.create(prefecture: '鳥取県', district: "中国")
Area.create(prefecture: '島根県', district: "中国")
Area.create(prefecture: '岡山県', district: "中国")
Area.create(prefecture: '広島県', district: "中国")
Area.create(prefecture: '山口県', district: "中国")
Area.create(prefecture: '徳島県', district: "四国")
Area.create(prefecture: '香川県', district: "四国")
Area.create(prefecture: '愛媛県', district: "四国")
Area.create(prefecture: '高知県', district: "四国")
Area.create(prefecture: '福岡県', district: "北部九州")
Area.create(prefecture: '佐賀県', district: "北部九州")
Area.create(prefecture: '長崎県', district: "北部九州")
Area.create(prefecture: '熊本県', district: "北部九州")
Area.create(prefecture: '大分県', district: "北部九州")
Area.create(prefecture: '宮崎県', district: "南九州・沖縄")
Area.create(prefecture: '鹿児島県', district: "南九州・沖縄")
Area.create(prefecture: '沖縄県', district: "南九州・沖縄")

puts "地域作成！"

# ゴルフ場データ作成

10.times do |i|
  n = i + 1
  golfclub = Golfclub.create!(
    name: "サンプルカントリー#{n}",
    home_page_url: "https://www.next-golf.jp/okinawa/",
    strategy_video: "https://youtu.be/cB01psesXvI",
    area_id: rand(1..47)
  )
  golfclub.photo.attach(io: File.open("./public/golfclub_photos/golfclub_sample_1.jpeg"), filename: "golfclub_sample_1.jpeg")
end

10.times do |i|
  n = i + 1
  golfclub = Golfclub.create!(
    name: "サンプルカントリー#{n + 10}",
    home_page_url: "http://fukuokacc.com/",
    strategy_video: "https://youtu.be/yId0rVY0jKs",
    area_id: rand(1..47)
  )
  golfclub.photo.attach(io: File.open("./public/golfclub_photos/golfclub_sample_2.jpeg"), filename: "golfclub_sample_2.jpeg")
end

10.times do |i|
  n = i + 1
  golfclub = Golfclub.create!(
    name: "サンプルカントリー#{n + 20}",
    home_page_url: "https://www.hawaiiprincegolf.com/",
    strategy_video: "https://youtu.be/3s8EtEjo81E",
    area_id: rand(1..47)
  )
  golfclub.photo.attach(io: File.open("./public/golfclub_photos/golfclub_sample_3.jpeg"), filename: "golfclub_sample_3.jpeg")
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

# hamano,course,out,hole_map
@course_id = Course.where(golfclub_id: 1).first.id
hole = Hole.where(golfclub_id: 1, course_id: @course_id).first
hole.map_r.attach(io: File.open("./public/hole_maps/hamano/out/hamano_h1_map_r.png"), filename: "hamano_h1_map_r.png")
hole.map_b.attach(io: File.open("./public/hole_maps/hamano/out/hamano_h1_map_b.png"), filename: "hamano_h1_map_b.png")
hole.map_l.attach(io: File.open("./public/hole_maps/hamano/out/hamano_h1_map_l.png"), filename: "hamano_h1_map_l.png")
hole.save
hole = Hole.where(golfclub_id: 1, course_id: @course_id).second
hole.map_r.attach(io: File.open("./public/hole_maps/hamano/out/hamano_h2_map_r.png"), filename: "hamano_h2_map_r.png")
hole.map_b.attach(io: File.open("./public/hole_maps/hamano/out/hamano_h2_map_b.png"), filename: "hamano_h2_map_b.png")
hole.map_l.attach(io: File.open("./public/hole_maps/hamano/out/hamano_h2_map_l.png"), filename: "hamano_h2_map_l.png")
hole.save
# hamano,course,in,hole_map
@course_id = Course.where(golfclub_id: 1).second.id
hole = Hole.where(golfclub_id: 1, course_id: @course_id).first
hole.map_r.attach(io: File.open("./public/hole_maps/hamano/in/hamano_h10_map_r.png"), filename: "hamano_h10_map_r.png")
hole.map_b.attach(io: File.open("./public/hole_maps/hamano/in/hamano_h10_map_b.png"), filename: "hamano_h10_map_b.png")
hole.map_l.attach(io: File.open("./public/hole_maps/hamano/in/hamano_h10_map_l.png"), filename: "hamano_h10_map_l.png")
hole.save
hole = Hole.where(golfclub_id: 1, course_id: @course_id).second
hole.map_r.attach(io: File.open("./public/hole_maps/hamano/in/hamano_h11_map_r.png"), filename: "hamano_h11_map_r.png")
hole.map_b.attach(io: File.open("./public/hole_maps/hamano/in/hamano_h11_map_b.png"), filename: "hamano_h11_map_b.png")
hole.map_l.attach(io: File.open("./public/hole_maps/hamano/in/hamano_h11_map_l.png"), filename: "hamano_h11_map_l.png")
hole.save
hole = Hole.where(golfclub_id: 1, course_id: @course_id).third
hole.map_r.attach(io: File.open("./public/hole_maps/hamano/in/hamano_h12_map_r.png"), filename: "hamano_h12_map_r.png")
hole.map_b.attach(io: File.open("./public/hole_maps/hamano/in/hamano_h12_map_b.png"), filename: "hamano_h12_map_b.png")
hole.map_l.attach(io: File.open("./public/hole_maps/hamano/in/hamano_h12_map_l.png"), filename: "hamano_h12_map_l.png")
hole.save

# # susono,course,out,hole_map
# @course_id = Course.where(golfclub_id: 2).first.id
# hole = Hole.where(golfclub_id: 2, course_id: @course_id).first
# hole.map_r.attach(io: File.open("./public/hole_maps/susono/out/susono_h1_map_r.png"), filename: "susono_h1_map_r.png")
# hole.map_b.attach(io: File.open("./public/hole_maps/susono/out/susono_h1_map_b.png"), filename: "susono_h1_map_b.png")
# hole.map_l.attach(io: File.open("./public/hole_maps/susono/out/susono_h1_map_l.png"), filename: "susono_h1_map_l.png")
# hole.save
# @course_id = Course.where(golfclub_id: 2).first.id
# hole = Hole.where(golfclub_id: 2, course_id: @course_id).second
# hole.map_r.attach(io: File.open("./public/hole_maps/susono/out/susono_h2_map_r.png"), filename: "susono_h2_map_r.png")
# hole.map_b.attach(io: File.open("./public/hole_maps/susono/out/susono_h2_map_b.png"), filename: "susono_h2_map_b.png")
# hole.map_l.attach(io: File.open("./public/hole_maps/susono/out/susono_h2_map_l.png"), filename: "susono_h2_map_l.png")
# hole.save

puts "ホール作成！"

# 攻略情報データ作成
# # hamano,out
hamano_out = []
2.times do |i|
  n = i + 1
  hamano_out.push( [
    ["hamano_h#{n}_tee.jpg"], ["hamano_h#{n}_2nd.jpg"], 
    ["hamano_h#{n}_3rd.jpg"], ["hamano_h#{n}_green.jpg"]
  ])
end
# hamanoのcourseがoutのデータ
# (golfclub_idが１をhamanoとする。)
@course_id = Course.where(golfclub_id: 1).first.id
@hole_first_id = Hole.where(golfclub_id: 1, course_id: @course_id).first.id
2.times do |i|
  array = hamano_out[i]
  n = i + 1
  array.each_with_index do |item, l|
    file = item[0]
    h = l + 1
    strategy_info = StrategyInfo.new
    strategy_info.golfclub_id = 1
    strategy_info.course_id = @course_id
    strategy_info.hole_id = @hole_first_id + i
    strategy_info.shot_id = l
    strategy_info.user_id = 1
    strategy_info.location_name = "R"
    strategy_info.photo.attach(
      io: File.open("./public/strategy_infos/hamano/out/#{item[0]}"),
      filename: "#{item[0]}")
    strategy_info.comment = "コメント#{h}"
    strategy_info.save
  end
end

# hamano,in
hamano_in = []
2.times do |i|
  hamano_in.push( [
    ["hamano_h1#{i}_tee.jpg"], ["hamano_h1#{i}_2nd.jpg"], 
    ["hamano_h1#{i}_green.jpg"]
  ])
end

hamano_in.push ([
  ["hamano_h12_tee.jpg"], ["hamano_h12_2nd.jpg"], 
  ["hamano_h12_3rd.jpg"], ["hamano_h12_green.jpg"]
])
# hamanoのcourseがinのデータ
@course_id = Course.where(golfclub_id: 1).second.id
@hole_first_id = Hole.where(golfclub_id: 1, course_id: @course_id).first.id
3.times do |i|
  array = hamano_in[i]
  n = i + 1
  array.each_with_index do |item, l|
    h = l + 1
    strategy_info = StrategyInfo.new
    strategy_info.golfclub_id = 1
    strategy_info.course_id = @course_id
    strategy_info.hole_id = @hole_first_id + i
    strategy_info.shot_id = l
    strategy_info.user_id = 1
    strategy_info.location_name = "R"
    strategy_info.photo.attach(
      io: File.open("./public/strategy_infos/hamano/in/#{item[0]}"),
      filename: "#{item[0]}")
    strategy_info.comment = "コメント#{h}"
    strategy_info.save
  end
end

# -----------------------------------------------------------------

# susono

puts "攻略情報作成！"

# Club情報作成
Club.create( yarn_count_string: 'W', yarn_count_number: 1, detail: 'MAVRIK 440ツアーバージョン（9°、グラファイトデザイン Tour AD XC-7TX）',loft: 10, largo: 45.75, weight: 316, balance_string: 'D', balance_number: '4', frequency: 250, user_id: 2)
Club.create( yarn_count_string: 'U', yarn_count_number: 3, detail: 'MAVRIK 440ツアーバージョン（9°、グラファイトデザイン Tour AD XC-7TX）',loft: 15, largo: 41.00, weight: 348, balance_string: 'D', balance_number: '0', frequency: 250, user_id: 2)
Club.create( yarn_count_string: 'U', yarn_count_number: 5, detail: 'MAVRIK 440ツアーバージョン（9°、グラファイトデザイン Tour AD XC-7TX）',loft: 25, largo: 40.50, weight: 415, balance_string: 'D', balance_number: '3', frequency: 250, user_id: 2)
Club.create( yarn_count_string: 'I', yarn_count_number: 5, detail: 'MAVRIK 440ツアーバージョン（9°、グラファイトデザイン Tour AD XC-7TX）',loft: 25, largo: 37.75, weight: 428, balance_string: 'D', balance_number: '3', frequency: 250, user_id: 2)
Club.create( yarn_count_string: 'I', yarn_count_number: 6, detail: 'MAVRIK 440ツアーバージョン（9°、グラファイトデザイン Tour AD XC-7TX）',loft: 25, largo: 37.25, weight: 435, balance_string: 'D', balance_number: '3', frequency: 250, user_id: 2)
Club.create( yarn_count_string: 'I', yarn_count_number: 7, detail: 'MAVRIK 440ツアーバージョン（9°、グラファイトデザイン Tour AD XC-7TX）',loft: 25, largo: 36.75, weight: 442, balance_string: 'D', balance_number: '3', frequency: 250, user_id: 2)
Club.create( yarn_count_string: 'I', yarn_count_number: 8, detail: 'MAVRIK 440ツアーバージョン（9°、グラファイトデザイン Tour AD XC-7TX）',loft: 25, largo: 36.25, weight: 449, balance_string: 'D', balance_number: '3', frequency: 250, user_id: 2)
Club.create( yarn_count_string: 'I', yarn_count_number: 9, detail: 'MAVRIK 440ツアーバージョン（9°、グラファイトデザイン Tour AD XC-7TX）',loft: 25, largo: 35.75, weight: 456, balance_string: 'D', balance_number: '3', frequency: 250, user_id: 2)
Club.create( yarn_count_string: 'PW', detail: 'MAVRIK 440ツアーバージョン（9°、グラファイトデザイン Tour AD XC-7TX）',loft: 25, largo: 35.25, weight: 465, balance_string: 'D', balance_number: '3', frequency: 250, user_id: 2)
Club.create( yarn_count_string: 'SW', detail: 'MAVRIK 440ツアーバージョン（9°、グラファイトデザイン Tour AD XC-7TX）',loft: 58, largo: 34.5, weight: 483, balance_string: 'D', balance_number: '3', frequency: 250, user_id: 2)

puts "クラブ作成！"


# カテゴリーデータ作成

Category.create(name: '料理')
Category.create(name: '施設')
Category.create(name: '周辺')

puts "カテゴリー作成！"

# 投稿データ作成

users = User.order(:created_at).where.not(id: 1).take(8)

5.times do |n|
  n = n + 1
  title = "タイトル#{n}"
  comment = "テスト投稿#{n}"

  users.each { |user|
    user_post = user.posts.create(
      title: title,
      comment: comment,
      golfclub_id: rand(1..30),
      category_id: rand(1..3)
    )
    user_post.photo.attach(io: File.open("./public/post_photos/post_sample.jpeg"), filename: "post_sample.jpeg")
  }
end

puts "投稿情報作成！"
