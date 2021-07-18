module GolfclubsHelper
  def course_count(golfclub, courses)
    if courses[golfclub.id].length <= 0
      "未登録"
    else
      courses[golfclub.id].length.to_s + 'コース'
    end
  end
end
