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