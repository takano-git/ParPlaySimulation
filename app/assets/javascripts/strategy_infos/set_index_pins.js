$(document).bind('turbolinks:load ajaxComplete',function() {
  // function photo() {
    // document.getElementById("photo_pin_point").onload = function() {
      // ここに読み込みが完了したら実行したい処理を記述する
      // console.log("ピン％化");
      // 写真
      const photo = document.getElementById("show_photo_area");
      const photo_x = photo.clientWidth;
      const photo_y = photo.clientHeight;
      const b_photo_x = Number('<%= @strategy_info.photo_size_x %>');
      const b_photo_y = Number('<%= @strategy_info.photo_size_y %>');
    // 写真、狙い目のピン
    const photo_pin_target = document.getElementById("photo_pin_target");
    const photo_target_style_x = Number('<%= @strategy_info.photo_target_x %>');
    const photo_target_style_y = Number('<%= @strategy_info.photo_target_y %>');
    photo_pin_target.style.left = (photo_target_style_x / b_photo_x)*100 + "%";
    photo_pin_target.style.top = (photo_target_style_y / b_photo_y)*100 + "%";
    // 写真、ポイントのピン
    const photo_pin_point = document.getElementById("photo_pin_point");
    const photo_point_style_x = Number('<%= @strategy_info.photo_point_x %>');
    const photo_point_style_y = Number('<%= @strategy_info.photo_point_y %>');
    photo_pin_point.style.left = (photo_point_style_x / b_photo_x)*100 + "%";
    photo_pin_point.style.top = (photo_point_style_y / b_photo_y)*100 + "%";
    // };
  // }
  // photo();
  
  // console.log("ピン％化map");
  // マップ
  const map = document.getElementById("strategy_main_map");
  const map_x = map.clientWidth;
  const map_y = map.clientHeight;
  const b_map_x = Number('<%= @strategy_info.map_size_x %>');
  const b_map_y = Number('<%= @strategy_info.map_size_y %>');
  // マップ、狙い目のピン
  const map_pin_target = document.getElementById("map_pin_target");
  const map_target_style_x = Number('<%= @strategy_info.map_target_x %>');
  const map_target_style_y = Number('<%= @strategy_info.map_target_y %>');
  map_pin_target.style.left = (map_target_style_x / b_map_x)*100 + "%";
  map_pin_target.style.top = (map_target_style_y / b_map_y)*100 + "%";
  // マップ、ポイントのピン
  const map_pin_point = document.getElementById("map_pin_point");
  const map_point_style_x = Number('<%= @strategy_info.map_point_x %>');
  const map_point_style_y = Number('<%= @strategy_info.map_point_y %>');
  map_pin_point.style.left = (map_point_style_x / b_map_x)*100 + "%";
  map_pin_point.style.top = (map_point_style_y / b_map_y)*100 + "%";
  // マップ、撮影地点のピン
  const map_pin_shoot = document.getElementById("map_pin_shoot");
  const map_shoot_style_x = Number('<%= @strategy_info.map_shoot_x %>');
  const map_shoot_style_y = Number('<%= @strategy_info.map_shoot_y %>');
  map_pin_shoot.style.left = (map_shoot_style_x / b_map_x)*100 + "%";
  map_pin_shoot.style.top = (map_shoot_style_y / b_map_y)*100 + "%";
});