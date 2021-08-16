$(document).bind('turbolinks:load ajaxComplete', function() {

  // ここからピンの移動

  // 
  // map
  const map_pin_target = document.getElementById("map_pin_target");
  const map_pin_point = document.getElementById("map_pin_point");
  const map_pin_shoot = document.getElementById("map_pin_shoot");
  // 1.map_target_pin
  //ドラッグ時の内容
  (function () {
    const pinMove = function onMouseMove(event){
      // let pin = document.getElementById("pin");
      map_pin_target.style.position = "absolute";
      map_pin_target.ondragstart = function(e){
      return false;
    }
    // pin要素、対windowのx,y座標
    let x = event.clientX;
    let y = event.clientY;
    // pin要素自身のx,y座標
    let width = map_pin_target.offsetWidth;
    let height = map_pin_target.offsetHeight;
    // map取得
    let map = document.querySelector('.regedit_map');
    let map_rect = map.getBoundingClientRect();
    let map_target_x = (x - map_rect.left)-width/2-4;
    let map_target_y = (y - map_rect.top)-height/2-4;
    // ty-height/2-2とtx+width/2-6の値をhiddenのvalueに入れる
    map_pin_target.style.left = map_target_x + "px";
    map_pin_target.style.top = map_target_y + "px";
    // const
    document.getElementById('map_target_x').value = map_target_x;
    document.getElementById('map_target_y').value = map_target_y;
    }
    // マウスが離れたとき
    map_pin_target.onmouseup = function(event){
      // console.log("離れたぞ！");
      document.removeEventListener("mousemove",pinMove, true);
      // document.getElementById("pin").ondragleave = null;
    }
    //ピン上でマウスが押下されたとき　
    map_pin_target.onmousedown = function(event){
      document.addEventListener("mousemove", pinMove, true)
    }
  }());
  
  
  // 2.regedit_map_pin_point
  (function () {
    const MapPinPointMove = function onMouseMove(event){
      // let map_pin_point = document.getElementById("map_pin_point");
      map_pin_point.style.position = "absolute";
      map_pin_point.ondragstart = function(e){
        return false;
      }
      // map_pin_point要素、対windowのx,y座標
      let x = event.clientX;
      let y = event.clientY;
      // map_pin_point要素自身のx,y座標
      let width = map_pin_point.offsetWidth;
      let height = map_pin_point.offsetHeight;
      // map取得
      let map = document.querySelector('.regedit_map');
      let map_point_rect = map.getBoundingClientRect();
      let map_point_x = (x - map_point_rect.left)-width/2-4;
      let map_point_y = (y - map_point_rect.top)-height/2-4;
      // ty-height/2-2とtx+width/2-6の値をhiddenのvalueに入れる
      map_pin_point.style.left = map_point_x + "px";
      map_pin_point.style.top = map_point_y + "px";
      // const
      document.getElementById('map_point_x').value = map_point_x;
      document.getElementById('map_point_y').value = map_point_y;
      // console.log("map要素から見たpin座標(x, y) = (" + map_point_x + "," + map_point_y + ")");
    }
    // let map_pin_point = document.getElementById("map_pin_point");
    map_pin_point.onmousedown = function(event){
      document.addEventListener("mousemove", MapPinPointMove, true)
    }
    map_pin_point.onmouseup = function(event){
      document.removeEventListener("mousemove",MapPinPointMove, true);
    }
  }());
  
  // 3.regedit_map_pin_shoot
  // shoot_pin
  (function () {
    const MapPinShootMove = function onMouseMove(event){
      // let map_pin_shoot = document.getElementById("map_pin_shoot");
      map_pin_shoot.style.position = "absolute";
      map_pin_shoot.ondragstart = function(e){
        return false;
      }
      // map_pin_shoot要素、対windowのx,y座標
      let x = event.clientX;
      let y = event.clientY;
      // map_pin_shoot要素自身のx,y座標
      let width = map_pin_shoot.offsetWidth;
      let height = map_pin_shoot.offsetHeight;
      // map取得
      let map = document.querySelector('.regedit_map');
      let map_shoot_rect = map.getBoundingClientRect();
      let map_shoot_x = (x - map_shoot_rect.left)-width/2-4;
      let map_shoot_y = (y - map_shoot_rect.top)-height/2-4;
      // ty-height/2-2とtx+width/2-6の値をhiddenのvalueに入れる
      map_pin_shoot.style.left = map_shoot_x + "px";
      map_pin_shoot.style.top = map_shoot_y + "px";
      // const
      document.getElementById('map_shoot_x').value = map_shoot_x;
      document.getElementById('map_shoot_y').value = map_shoot_y;
      
      // photoサイズの書き換え
      document.getElementById('map_size_x').value = map.offsetWidth;
      document.getElementById('map_size_y').value = map.offsetHeight;
    }
    // let map_pin_shoot = document.getElementById("map_pin_shoot");
    map_pin_shoot.onmousedown = function(event){
      document.addEventListener("mousemove", MapPinShootMove, true)
    }
    map_pin_shoot.onmouseup = function(event){
      document.removeEventListener("mousemove",MapPinShootMove, true);
    }
  }());
  

  
  // 
  // photo
  // 4.photo_pin_target
  (function () {
    let photo_pin_target = document.getElementById("photo_pin_target");
    const PhotoPinTargetMove = function onMouseMove(event){
      photo_pin_target.style.position = "absolute";
      photo_pin_target.ondragstart = function(e){
        return false;
      }
      // photo_pin_target要素、対windowのx,
      let x = event.clientX;
      let y = event.clientY;
      // photo_pin_target要素自身のx,y座標
      let width = photo_pin_target.offsetWidth;
      let height = photo_pin_target.offsetHeight;
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
      let photo_target_rect = photo.getBoundingClientRect();
      let photo_target_x = (x - photo_target_rect.left)-width/2-2;
      let photo_target_y = (y - photo_target_rect.top)-height/2-3;
      // ty-height/2-2とtx+width/2-6の値をhiddenのvalueに入れる
      // photo_pin_target.style.left = photo_target_x + "px";
      // photo_pin_target.style.top = photo_target_y + "px";
      photo_pin_target.style.left = (photo_target_x/photo.offsetWidth)*100 + "%";
      photo_pin_target.style.top = (photo_target_y/photo.offsetHeight)*100 + "%";
      // hidden_fieldのvalue書き換え
      // ピン座標の書き換え
      document.getElementById('photo_target_x').value = photo_target_x;
      document.getElementById('photo_target_y').value = photo_target_y;
      // photoサイズの書き換え
      document.getElementById('photo_size_x').value = photo.offsetWidth;
      document.getElementById('photo_size_y').value = photo.offsetHeight;
    }
    photo_pin_target.onmousedown = function(event){
      document.addEventListener("mousemove", PhotoPinTargetMove, true)
    }
    photo_pin_target.onmouseup = function(event){
      document.removeEventListener("mousemove",PhotoPinTargetMove, true);
    }
  }());
  
  // 5.photo_pin_point
  (function () {
    let photo_pin_point = document.getElementById("photo_pin_point");
    const PhotoPinPointMove = function onMouseMove(event){
      photo_pin_point.style.position = "absolute";
      photo_pin_point.ondragstart = function(e){
        return false;
      }
      // photo_pin_point要素、対windowのx,y座標
      let x = event.clientX;
      let y = event.clientY;
      // photo_pin_point要素自身のx,y座標
      let width = photo_pin_point.offsetWidth;
      let height = photo_pin_point.offsetHeight;
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
      
      let photo_point_rect = photo.getBoundingClientRect();
      let photo_point_x = (x - photo_point_rect.left)-width/2-2;
      let photo_point_y = (y - photo_point_rect.top)-height/2-3;
      // ty-height/2-2とtx+width/2-6の値をhiddenのvalueに入れる
      // photo_pin_point.style.left = photo_point_x + "px";
      // photo_pin_point.style.top = photo_point_y + "px";
      photo_pin_point.style.left = (photo_point_x/photo.offsetWidth)*100 + "%";
      photo_pin_point.style.top = (photo_point_y/photo.offsetHeight)*100 + "%";
      // hidden_fieldのvalue書き換え
      // ピン座標の書き換え
      document.getElementById('photo_point_x').value = photo_point_x;
      document.getElementById('photo_point_y').value = photo_point_y;
      // photoサイズの書き換え
      document.getElementById('photo_size_x').value = photo.offsetWidth;
      document.getElementById('photo_size_y').value = photo.offsetHeight;
    }
    photo_pin_point.onmousedown = function(event){
      document.addEventListener("mousemove", PhotoPinPointMove, true)
    }
    photo_pin_point.onmouseup = function(event){
      document.removeEventListener("mousemove",PhotoPinPointMove, true);
    }
  }());
});