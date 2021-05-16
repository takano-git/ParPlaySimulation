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

// window.onload = function(){
// $(document).ready(function(){
// console.log("payjpstart");
// function main() {
  document.addEventListener(
    "DOMContentLoaded", e => {
      // "token_submit"というidをもつhtmlがあるページか？つまりカード作成ページかを判定
      if (document.getElementById("token_submit") != null) {
        // console.log("token_submit != null");
        // console.log("getElementById");
        Payjp.setPublicKey("pk_test_91c2a9b5f4d2d2ba4b24e7b6");
        // 送信ボタンをbtnに格納
        let btn = document.getElementById("token_submit");
        // console.log(btn);
        // 送信ボタンがクリックされたとき
        btn.addEventListener("click", e => {
          // デフォルトのブラウザの動き(createアクションへの遷移)をいったん止める。
          e.preventDefault();
          // cardに入力された値をハッシュで格納
          let card = {
            number: document.getElementById("card_number").value,
            cvc: document.getElementById("cvc").value,
            exp_month: document.getElementById("exp_month").value,
            exp_year: document.getElementById("exp_year").value
          };
          // console.log(card);
          // カード情報をpayjpに送りカードトークンを(response.id)を受け取る。
          Payjp.createToken(card, (status, response) => {
            // 正常な値の場合
            // console.log("status=",status);
            if (status === 200) {
              // name属性を削除することにより、データーベースに送るのを防ぐ。
              $("#card_number").removeAttr("name");
              $("#cvc").removeAttr("name");
              $("#exp_month").removeAttr("name");
              $("#exp_year").removeAttr("name"); 
              // <input type="hidden" name="payjp-token" value= response.id>が#card_tokenに追加される。
              $("#card_token").append(
                $('<input type="hidden" name="payjp-token">').val(response.id)
              ); 
              if (!confirm('この内容でよろしかったですか？')) {
                /* キャンセルの時の処理 */
                return false;
              } else {
                /* OKの時の処理  今回は特に処理がないので空*/
              }
              // inputFormのsubmitを発動。（上記で停止していた）
              document.inputForm.submit();
            // 不正な値の場合
            } else {
              alert("カード情報が正しくありません。");
            }
          });
        });
      }
    },
    false
  );
//



// if (document.readyState !== "loading") {
//   main();
// } else {
//   document.addEventListener("DOMContentLoaded", main, false);
// }









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