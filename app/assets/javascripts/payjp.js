// $(function() {
//   if (!$('#regist_card')[0]) return false;
  
//   Payjp.setPublicKey('pk_test_91c2a9b5f4d2d2ba4b24e7b6');

//   $("#regist_card").on("click", function(e) {
//     e.preventDefault();
//     var card = {
//         number: $("#number_form").val(),
//         exp_month: $("#exp_month_form").val(),
//         exp_year: $("#exp_year_form").val(),
//         cvc: $("#cvc_form").val()
//     };

//     Payjp.createToken(card, function(status, response) {
//       console.log("status:"status)
//       if (status === 200) {
//         $("#number_form").removeAttr("name");
//         $("#exp_month_form").removeAttr("name");
//         $("#exp_year_form").removeAttr("name");
//         $("#cvc_form").removeAttr("name");
//         var token = response.id;
//         $("#card_token").append(`<input type="hidden" name="card_token" value=${token}>`)
//         $("#card_form").get(0).submit();
//       } else {
//         alert("カード情報が正しくありません。");
//         $("#regist_card").prop('disabled', false);
//       }
//     });
//   });
// });



document.addEventListener(
  "DOMContentLoaded", e => {
    if (document.getElementById("token_submit") != null) {
      // "token_submit"というidをもつhtmlがあるページか？つまりカード作成ページか
      Payjp.setPublicKey("pk_test_91c2a9b5f4d2d2ba4b24e7b6"); 
      let btn = document.getElementById("token_submit");  // 送信ボタンをbtnに格納
      btn.addEventListener("click", e => {  // 送信ボタンがクリックされたとき
        e.preventDefault(); // デフォルトのブラウザの動きをいったんとめる(createアクションへの遷移を)
        let card = {  // cardに入力された値をハッシュで格納
          number: document.getElementById("card_number").value,
          cvc: document.getElementById("cvc").value,
          exp_month: document.getElementById("exp_month").value,
          exp_year: document.getElementById("exp_year").value
        };
        Payjp.createToken(card, (status, response) => {
          // カード情報をpayjpに送りカードトークンを(response.id)を受け取る。
          if (status === 200) {  // 正常な値の場合 
            $("#card_number").removeAttr("name");
            $("#cvc").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name"); 
            // name属性を削除することにより、dataベースに送るのを防ぐ。
            $("#card_token").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
              // <input type="hidden" name="payjp-token" value= response.id>が#card_tokenに追加される。
            ); 
            if(!confirm('この内容でよろしかったですか？')){
                /* キャンセルの時の処理 */
                return false;
            }else{
                /* OKの時の処理  今回は特に処理がないので空*/
            }
            document.inputForm.submit(); // inputFormのsubmitを発動。（上記で停止していた）
          } else {
            alert("カード情報が正しくありません。");
          }
        });
      });
    }
  },
  false
);

// $(document).on('turbolinks:load', function() {
//   var form = $("#charge-form");
//   Payjp.setPublicKey('pk_test_91c2a9b5f4d2d2ba4b24e7b6');
//   $(document).on("click", "#submit-button", function(e) {

//     e.preventDefault();
//     form.find("input[type=submit]").prop("disabled", true);

//     var card = {
//         number: $("#payment_card_no").val(),
//         cvc: $("#payment_card_cvc").val(),
//         exp_month: $("#payment_expiration_date_1i").val(),
//         exp_year: $("#payment_expiration_date_2i").val(),
//     };
//     Payjp.createToken(card, function(s, response) {
//       if (response.error) {
//         alert('トークン作成エラー発生');
//       }
//       else {
//         $(".number").removeAttr("name");
//         $(".cvc").removeAttr("name");
//         $(".exp_month").removeAttr("name");
//         $(".exp_year").removeAttr("name");
//         var token = response.id;

//         form.append($('<input type="hidden" name="payjpToken" />').val(token));
//         form.get(0).submit();
//       }
//     });
//   });
// });