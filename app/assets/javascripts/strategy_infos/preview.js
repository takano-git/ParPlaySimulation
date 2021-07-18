// アップロードする画像ファイル表示
jQuery(document).bind('turbolinks:load ajaxComplete',function() {
  const photo_prev_src = document.getElementById('photo_prev').getAttribute('src');
  $('#admin_photo').val(photo_prev_src);
  const photo_area = $('#photo_area');
    
  $("#f_strategy_photo").on('change', function(){
    const fileprop = $(this).prop('files')[0];
    //  find_img 画像表示部分
    const find_img = $("#photo_selected");
    const fileRdr = new FileReader();
    // find_imgがあればimgを消去
    if(find_img.length) {
      find_img.remove();
    }
    const img = '<img id="photo_selected", class="strategy_img strategy_photo">'
    // .propメソッド―選択地取得('files'（ファイル名）取得)
    //　filepropがない場合、@strategy_info_admin.photo表示
    if( $("#f_strategy_photo").prop('files')[0] === undefined ){
      $('#photo_prev').show();
    } else {
      $('#photo_prev').hide();
      photo_area.append(img);
      fileRdr.onload = function() {
        photo_area.find('#photo_selected').attr('src', fileRdr.result);
      }
      fileRdr.readAsDataURL(fileprop);
    };
    // 画像サイズ取得
    let photo_size_x = document.getElementById('photo_area').clientWidth;
    let photo_size_y = document.getElementById('photo_area').clientHeight;
    document.getElementById('photo_size_x').value = photo_size_x;
    document.getElementById('photo_size_y').value = photo_size_y;
    
  });
    
});