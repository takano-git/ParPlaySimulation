
// $(親要素).on('change', '子要素' )...
jQuery(document).bind('turbolinks:load ajaxComplete', function() {

  $('#course_id, #hole_id, #shot_id, #location_name').change(function() {
    const course_first = $('select#course_id').val();
    let switchPath = $('select#course_id').find('option:selected').data().childrenPath;
    let course_id = $('select#course_id').val();
    let hole_id = $('select#hole_id').val();
    let shot_id = $('select#shot_id').val();
    let location_name = $('select#location_name').val();
    
    $.ajax({
      url: switchPath,
      type: "GET",
      data: {
        course_first: course_first,
        course_id: course_id,
        hole_id: hole_id,
        shot_id: shot_id,
        location_name: location_name,
      },
    });
  });

});