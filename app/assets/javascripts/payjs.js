$(function() {
  if (!$('#regist_card')[0]) return false;
  
  Payjp.setPublicKey('pk_test_91c2a9b5f4d2d2ba4b24e7b6');

  $("#regist_card").on("click", function(e) {
    e.preventDefault();
    var card = {
        number: $("#number_form").val(),
        exp_month: $("#exp_month_form").val(),
        exp_year: $("#exp_year_form").val(),
        cvc: $("#cvc_form").val()
    };

    Payjp.createToken(card, function(status, response) {
      if (status === 200) {
        $("#number_form").removeAttr("name");
        $("#exp_month_form").removeAttr("name");
        $("#exp_year_form").removeAttr("name");
        $("#cvc_form").removeAttr("name");
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