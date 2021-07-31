// jQuery(document).bind('turbolinks:load ajaxComplete', function() {
  //　初期photo_size photoは読み込みに時間がかかるのでonload
  const photo = document.getElementById('photo_prev');
  photo.onload = function() {
    const photo_size_x = document.getElementById('photo_area').clientWidth;
    const photo_size_y = document.getElementById('photo_area').clientHeight;
  };
  //　初期map_size
  const map_size_x = document.getElementById('strategy_map').clientWidth;
  const map_size_y = document.getElementById('strategy_map').clientHeight;
  // }

  // window.onload = function() {
    const getSize = function(element){

    };
    
    let photo_area = document.getElementById('photo_area');
    // window変更時のphoto_size,map_size取得
    window.addEventListener( 'resize', function() {
      // photoサイズ(ap(after_photo),bp(before_photo))
    // offsetXやclientWidthでは小数点以下が切られる
    const ap_size_x = document.getElementById('photo_area').getBoundingClientRect().width;
    const ap_size_y = document.getElementById('photo_area').getBoundingClientRect().height;
    // const ap_size_x = document.getElementById('photo_area').clientWidth;
    // const ap_size_y = document.getElementById('photo_area').clientHeight;
    // mapサイズ
    const am_size_x = document.getElementById('strategy_map').getBoundingClientRect().width;
    const am_size_y = document.getElementById('strategy_map').getBoundingClientRect().height;
    
    // (prosses1)
    // 変更前のphoto（map）サイズ：変更前のpin座標
    // = 変更後のphoto（map）サイズ：求めたい値（変更後のpin座標）
    // bp_size_x : bp_target_x = ap_size_x: ap_target_x
    ap_target_x = (Number(bp_target_x.value) * ap_size_x)/Number(bp_size_x.value);
    ap_target_y = (Number(bp_target_y.value) * ap_size_y)/Number(bp_size_y.value);
    let photo_pin_target = document.getElementById("photo_pin_target");
    // pin要素自身のx,y座標
    let width = photo_pin_target.offsetWidth;
    let height = photo_pin_target.offsetHeight;
    // pin移動
      photo_pin_target.style.left = (ap_target_x + width/2) + "px";
      photo_pin_target.style.top = (ap_target_y + height/2) + "px";
    // photo_pin_target.style.left = ap_target_x + "px";
    // photo_pin_target.style.top = ap_target_y + "px";
    // photo_pin_target.style.top = ap_target_y + "px";
   
    })
    
    
  // });
    