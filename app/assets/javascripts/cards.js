$(function() {
  if (!$('#regist_card')[0]) return false;
  
  Payjp.setPublicKey("pk_test_e2b5e884b0680ac67ca97467");

  $("#regist_card").on("click", function(e) {
    e.preventDefault();
    // カード情報の取得
    var card = {
        number: $("#card_number_form").val(),
        exp_month: $("#exp_month_form").val(),
        exp_year: $("#exp_year_form").val(),
        cvc: $("#cvc_form").val()
    };

    // 取得したカード情報を元にトークン作成
    Payjp.createToken(card, function(status, response) {
      if (status === 200) {
        $("#card_number_form").removeAttr("name");
        $("#exp_month_form").removeAttr("name");
        $("#exp_year_form").removeAttr("name");
        $("#cvc_form").removeAttr("name");
        // トークンをコントローラーに送信
        var token = response.id;
        $("#card_token").append(`<input type="hidden" name="card_token" value=${token}>`)
        $("#card_form").get(0).submit();
      } else {
        alert("カード情報が正しくありません。");
        $("#regist_card").prop('disabled', false);
      }
    });
  });
});