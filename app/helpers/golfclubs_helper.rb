module GolfclubsHelper
  def course_count(golfclub)
    if golfclub.courses.count <= 0
      "未登録"
    else
      golfclub.courses.count.to_s + 'コース'
    end
  end
end
