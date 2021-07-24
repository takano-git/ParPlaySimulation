module CoursesHelper
  def hole_map_r(course, hole)
    course.holes.find(hole.object.id).map_r
  end

  def hole_map_b(course, hole)
    course.holes.find(hole.object.id).map_b
  end

  def hole_map_l(course, hole)
    course.holes.find(hole.object.id).map_l
  end
end
