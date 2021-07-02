
window.onload = function() {

  // ここからピンの移動
  const pin = document.getElementById("pin");
  const map_pin_point = document.getElementById("map_pin_point");
  const map_pin_shoot = document.getElementById("map_pin_shoot");
  // 1.map_target_pin
  //ドラッグ時の内容
  const pinMove = function onMouseMove(event){
    // let pin = document.getElementById("pin");
    pin.style.position = "absolute";
    pin.ondragstart = function(e){
      return false;
    }
    // pin要素、対windowのx,y座標
    let x = event.clientX;
    let y = event.clientY;
    // pin要素自身のx,y座標
    let width = pin.offsetWidth;
    let height = pin.offsetHeight;
    // map取得
    let map_r = document.querySelector('#map_r');
    let map_b = document.querySelector('#map_b');
    let map_l = document.querySelector('#map_l');
    //mapのdisplay状態
    display_map_r = getComputedStyle(map_r).display;
    display_map_b = getComputedStyle(map_b).display;
    display_map_l = getComputedStyle(map_l).display;
    // 表示中のmap取得
    let map = null; // if文の外で宣言する
    if (display_map_r !== "none"){
      map = map_r;
    } else if (display_map_b !== "none"){
      map = map_b;
    } else {
      map = map_l;
    }
    let map_rect = map.getBoundingClientRect();
    let map_target_x = (x - map_rect.left)+width/2-6;
    let map_target_y = (y - map_rect.top)-height/2-4;
    // ty-height/2-2とtx+width/2-6の値をhiddenのvalueに入れる
    pin.style.left = map_target_x + "px";
    pin.style.top = map_target_y + "px";
    // const
    document.getElementById('map_target_x').value = map_target_x;
    document.getElementById('map_target_y').value = map_target_y;
    // --
    // pin.onmouseup = function(event){
    //   console.log("離れたぞ！");
    //   // document.removeEventListener("mousemove",onMouseMove,true);
    //   document.removeEventListener("mousemove", onMouseMove, false);
    // }
    // --
  }
  // マウスが離れたとき
  pin.onmouseup = function(event){
    // console.log("離れたぞ！");
    document.removeEventListener("mousemove",pinMove, true);
    // document.getElementById("pin").ondragleave = null;
  }
  //ピン上でマウスが押下されたとき　
  pin.onmousedown = function(event){
    document.addEventListener("mousemove", pinMove, true)
  }
  // pin.onmousedown = function(event){
  //   document.addEventListener("mousemove", {
  //     argumentPin: pin,
  //     handleEvent: onMouseMove,
  //   }, true);
  // }


  // 
  // 2.map_pin_point
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
    let map_r = document.querySelector('#map_r');
    let map_b = document.querySelector('#map_b');
    let map_l = document.querySelector('#map_l');
    //mapのdisplay状態
    display_map_r = getComputedStyle(map_r).display;
    display_map_b = getComputedStyle(map_b).display;
    display_map_l = getComputedStyle(map_l).display;
    // 表示中のmap取得
    let map = null; // if文の外で宣言する
    if (display_map_r !== "none"){
      map = map_r;
    } else if (display_map_b !== "none"){
      map = map_b;
    } else {
      map = map_l;
    }
    let map_point_rect = map.getBoundingClientRect();
    let map_point_x = (x - map_point_rect.left)+width/2-6;
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

  // 3.map_pin_shoot
  // shoot_pin
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
    let map_r = document.querySelector('#map_r');
    let map_b = document.querySelector('#map_b');
    let map_l = document.querySelector('#map_l');
    //mapのdisplay状態
    display_map_r = getComputedStyle(map_r).display;
    display_map_b = getComputedStyle(map_b).display;
    display_map_l = getComputedStyle(map_l).display;
    // 表示中のmap取得
    let map = null; // if文の外で宣言する
    if (display_map_r !== "none"){
      map = map_r;
    } else if (display_map_b !== "none"){
      map = map_b;
    } else {
      map = map_l;
    }
    let map_shoot_rect = map.getBoundingClientRect();
    let map_shoot_x = (x - map_shoot_rect.left)+width/2-6;
    let map_shoot_y = (y - map_shoot_rect.top)-height/2-4;
    // ty-height/2-2とtx+width/2-6の値をhiddenのvalueに入れる
    map_pin_shoot.style.left = map_shoot_x + "px";
    map_pin_shoot.style.top = map_shoot_y + "px";
    // const
    document.getElementById('map_shoot_x').value = map_shoot_x;
    document.getElementById('map_shoot_y').value = map_shoot_y;
  }
  // let map_pin_shoot = document.getElementById("map_pin_shoot");
  map_pin_shoot.onmousedown = function(event){
    document.addEventListener("mousemove", MapPinShootMove, true)
  }
  map_pin_shoot.onmouseup = function(event){
    document.removeEventListener("mousemove",MapPinShootMove, true);
  }


  // 4.photo_pin_target
  let photo_pin_target = document.getElementById("photo_pin_target");
  const PhotoPinTargetMove = function onMouseMove(event){
    photo_pin_target.style.position = "absolute";
    photo_pin_target.ondragstart = function(e){
      return false;
    }
    // photo_pin_target要素、対windowのx,y座標
    let x = event.clientX;
    let y = event.clientY;
    // photo_pin_target要素自身のx,y座標
    let width = photo_pin_target.offsetWidth;
    let height = photo_pin_target.offsetHeight;
    // photo取得
    let photo = document.querySelector('#photo_prev');

    let photo_target_rect = photo.getBoundingClientRect();
    let photo_target_x = (x - photo_target_rect.left)-width/2-2;
    let photo_target_y = (y - photo_target_rect.top)-height/2-3;
    // ty-height/2-2とtx+width/2-6の値をhiddenのvalueに入れる
    photo_pin_target.style.left = photo_target_x + "px";
    photo_pin_target.style.top = photo_target_y + "px";
    // const
    document.getElementById('photo_target_x').value = photo_target_x;
    document.getElementById('photo_target_y').value = photo_target_y;
  }
  photo_pin_target.onmousedown = function(event){
    document.addEventListener("mousemove", PhotoPinTargetMove, true)
  }
  photo_pin_target.onmouseup = function(event){
    document.removeEventListener("mousemove",PhotoPinTargetMove, true);
  }



  // 5.photo_pin_point
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
    let photo = document.querySelector('#photo_prev');

    let photo_point_rect = photo.getBoundingClientRect();
    let photo_point_x = (x - photo_point_rect.left)-width/2-2;
    let photo_point_y = (y - photo_point_rect.top)-height/2-3;
    // ty-height/2-2とtx+width/2-6の値をhiddenのvalueに入れる
    photo_pin_point.style.left = photo_point_x + "px";
    photo_pin_point.style.top = photo_point_y + "px";
    // const
    document.getElementById('photo_point_x').value = photo_point_x;
    document.getElementById('photo_point_y').value = photo_point_y;
  }
  photo_pin_point.onmousedown = function(event){
    document.addEventListener("mousemove", PhotoPinPointMove, true)
  }
  photo_pin_point.onmouseup = function(event){
    document.removeEventListener("mousemove",PhotoPinPointMove, true);
  }



  // // 6.photo_pin_shoot
  // let photo_pin_shoot= document.getElementById("photo_pin_shoot");
  // const PhotoPinShootMove = function onMouseMove(event){
  //   photo_pin_shoot.style.position = "absolute";
  //   photo_pin_shoot.ondragstart = function(e){
  //     return false;
  //   }
  //   // photo_pin_shoot要素、対windowのx,y座標
  //   let x = event.clientX;
  //   let y = event.clientY;
  //   // photo_pin_shoot要素自身のx,y座標
  //   let width = photo_pin_shoot.offsetWidth;
  //   let height = photo_pin_shoot.offsetHeight;
  //   // photo取得
  //   let photo = document.querySelector('#photo_prev');

  //   let photo_shoot_rect = photo.getBoundingClientRect();
  //   let photo_shoot_x = (x - photo_shoot_rect.left)-width/2-2;
  //   let photo_shoot_y = (y - photo_shoot_rect.top)-height/2-3;
  //   // ty-height/2-2とtx+width/2-6の値をhiddenのvalueに入れる
  //   photo_pin_shoot.style.left = photo_shoot_x + "px";
  //   photo_pin_shoot.style.top = photo_shoot_y + "px";
  //   // const
  //   document.getElementById('photo_shoot_x').value = photo_shoot_x;
  //   document.getElementById('photo_shoot_y').value = photo_shoot_y;
  // }
  // photo_pin_shoot.onmousedown = function(event){
  //   document.addEventListener("mousemove", PhotoPinShootMove, true)
  // }
  // photo_pin_shoot.onmouseup = function(event){
  //   document.removeEventListener("mousemove",PhotoPinShootMove, true);
  // }

  
  
  
  // ------------ここまで-------------------------------------------
    

  // コースボタン切り替えによるホールボタン&マップの切り替え
  $(function() {
    $('select#course').change(function() {
      let course_id = $(this).val();
      let childrenPath = $(this).find('option:selected').data().childrenPath;
      // shot情報も追加
      let location_name = $('.l_selected').text();
      course_data = { 
        course: {
          course_id: course_id,
        }
      };
      $.ajax({
        url: childrenPath,
        type: "GET",
        data: {
          id: "",
          location_name: location_name,
          course_data
        },
      });
    });
  });
// --------------------------------------------------


  // ホールボタン切り替えによるマップの切り替え
  $(function() {
    $('select#hole').change(function() {
      let hole_id = $(this).val();
      let course_id = $('select#course').val();
      let holePath = $(this).find('option:selected').data().holePath;
      let location_name = $('.l_selected').text();
      console.log(holePath);
      hole_data = { 
        hole: {
          course_id: course_id,
          hole_id: hole_id,
        }
      };
      $.ajax({
        url: holePath,
        type: "GET",
        data: { id: "", location_name: location_name, hole_data },
      });
    });
  });

  // --------------------------------------------------


  // アップロードする画像ファイル表示
  $(function() {
    function readURL(input) {
      if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
          $('#photo_prev').attr('src', e.target.result);
        } 
        reader.readAsDataURL(input.files[0]);
        let photo_size_x = document.getElementById('photo_area').clientWidth;
        let photo_size_y = document.getElementById('photo_area').clientHeight;
        document.getElementById('photo_size_x').value = photo_size_x;
        document.getElementById('photo_size_y').value = photo_size_y;
      }
    }
    $("#f_strategy_photo").change(function(){
      readURL(this);
    });
  });

  // ---------------------------------------------------


  // window変更時のphoto_size,map_size取得
  window.addEventListener( 'resize', function() {
    // photo
    let photo_size_x = document.getElementById('photo_area').clientWidth;
    let photo_size_y = document.getElementById('photo_area').clientHeight;
    document.getElementById('photo_size_x').value = photo_size_x;
    document.getElementById('photo_size_y').value = photo_size_y;
    // map
    let map_size_x = document.getElementById('strategy_map').clientWidth;
    let map_size_y = document.getElementById('strategy_map').clientHeight;
    document.getElementById('map_size_x').value = map_size_x;
    document.getElementById('map_size_y').value = map_size_y;
  }, false );

  // --------------------------------------------------------------------

  //　初期map_size
  let map_size_x = document.getElementById('strategy_map').clientWidth;
  let map_size_y = document.getElementById('strategy_map').clientHeight;
  document.getElementById('map_size_x').value = map_size_x;
  document.getElementById('map_size_y').value = map_size_y;

  // --------------------------------

  // map表示切替(hole.htmlに記述済み)
  $("#map_b").hide();
  $("#map_l").hide();

  $('.location_btn').on('click', function () {
    let val = $(this).attr('id');
    let remove_val = $('.l_selected').attr('id');
    $("#map_" + remove_val).hide();
    $('.location_btn').removeClass('l_selected');
    $(this).addClass('l_selected');
    $("#map_" + val).show();
    document.getElementById('hidden_location').value = $('.l_selected').text();;
  });
  // ---------------------------------------------




}
