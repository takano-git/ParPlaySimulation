jQuery(document).bind('turbolinks:load ajaxComplete', function() {

  // window変更時のphoto_size,map_size取得
  window.addEventListener( 'resize', function() {
    // photoサイズ(ap(after_photo),bp(before_photo))
    // offsetXやclientWidthでは小数点以下が切られる
    const ap_size_x = document.getElementById('photo_area').getBoundingClientRect().width;
    const ap_size_y = document.getElementById('photo_area').getBoundingClientRect().height;
    // const ap_size_x = document.getElementById('photo_area').clientWidth;
    // const ap_size_y = document.getElementById('photo_area').clientHeight;
    const bp_size_x = document.getElementById('photo_size_x');
    const bp_size_y = document.getElementById('photo_size_y');
    // mapサイズ
    const am_size_x = document.getElementById('strategy_map').getBoundingClientRect().width;
    const am_size_y = document.getElementById('strategy_map').getBoundingClientRect().height;
    const bm_size_x = document.getElementById('map_size_x');
    const bm_size_y = document.getElementById('map_size_y');
    
    // pin位置(bp(before_photo),bm(before_map))取得
    // const pin_target_x = document.getElementById('photo_target_x');
    // const pin_target_y = document.getElementById('photo_target_y');

    // photoのピン
    const photo_pin_target = document.getElementById('photo_pin_target').getBoundingClientRect();
    const photo_pin_point = document.getElementById('photo_pin_point').getBoundingClientRect();
    let photo_pin_target_x = photo_pin_target.top;
    let photo_pin_target_y = photo_pin_target.left;
    let photo_pin_point_x = photo_pin_point.top;
    let photo_pin_point_y = photo_pin_point.left;
    // photo取得
    let prev_display = document.getElementById('photo_prev');
    let prev_display_css = getComputedStyle(prev_display).display;
    // 管理者のphotoかユーザーのphoto、どちらが表示されているか
    let photo = ""
    if (prev_display_css !== "none"){
      photo = document.querySelector('#photo_prev');
    } else {
      photo = document.querySelector('#photo_selected');
    }
    let photo_rect = photo.getBoundingClientRect();
    document.getElementById('photo_target_x').value = photo_pin_target_x - photo_rect.left;
    document.getElementById('photo_target_y').value = photo_pin_target_y - photo_rect.top;
    document.getElementById('photo_point_x').value = photo_pin_point_x - photo_rect.left;
    document.getElementById('photo_point_y').value = photo_pin_point_y - photo_rect.top;


    // mapのピン
    const map_pin_target = document.getElementById('map_pin_target').getBoundingClientRect();
    const map_pin_point = document.getElementById('map_pin_point').getBoundingClientRect();
    const map_pin_shoot = document.getElementById('map_pin_shoot').getBoundingClientRect();
    let map_pin_target_x = map_pin_target.top;
    let map_pin_target_y = map_pin_target.left;
    let map_pin_point_x = map_pin_point.top;
    let map_pin_point_y = map_pin_point.left;
    let map_pin_shoot_x = map_pin_shoot.top;
    let map_pin_shoot_y = map_pin_shoot.left;
    // map取得
    let map = document.querySelector('.regedit_map');
    let map_rect = map.getBoundingClientRect();
    document.getElementById('map_target_x').value = map_pin_target_x - map_rect.left;
    document.getElementById('map_target_y').value = map_pin_target_y - map_rect.top;
    document.getElementById('map_point_x').value = map_pin_point_x - map_rect.left;
    document.getElementById('map_point_y').value = map_pin_point_y - map_rect.top;
    document.getElementById('map_shoot_x').value = map_pin_shoot_x - map_rect.left;
    document.getElementById('map_shoot_y').value = map_pin_shoot_y - map_rect.top;
    

    // 写真、マップ画像サイズのhidden_fieldのvalue書き換え
    bp_size_x.value = ap_size_x;
    bp_size_y.value = ap_size_y;
    bm_size_x.value = am_size_x;
    bm_size_y.value = am_size_y;
    
  }, false );
  
  
});
    
    