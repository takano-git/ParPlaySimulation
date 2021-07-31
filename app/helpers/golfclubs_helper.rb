module GolfclubsHelper
  def course_count(golfclub, courses)
    if courses[golfclub.id].nil?
      "未登録"
    else
      courses[golfclub.id].length.to_s + 'コース'
    end
  end

  def golfclub_open(golfclub)
    if golfclub.closed?
      content_tag(:span, '閉鎖', style: "color: #dc3545;")
    else
      content_tag(:span, '営業中', style: "color: #28a745;")
    end
  end

  def golfclub_open_bg_color(golfclub)
    if golfclub.closed?
      'table-secondary'
    else
      'table-default'
    end
  end
end
