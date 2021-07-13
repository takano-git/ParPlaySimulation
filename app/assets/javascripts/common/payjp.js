// function main() {
  // console.log("payjp.js start");
  document.addEventListener(
    "DOMContentLoaded", e => {
      // "token_submit"というidをもつhtmlがあるページか？つまりカード作成ページかを判定
      if (document.getElementById("token_submit") != null) {
        Payjp.setPublicKey("pk_test_e2b5e884b0680ac67ca97467");
        // 送信ボタンをbtnに格納
        let btn = document.getElementById("token_submit");
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
          // カード情報をpayjpに送りカードトークンを(response.id)を受け取る。
          Payjp.createToken(card, (status, response) => {
            // 正常な値の場合
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
// }

// if (document.readyState !== "loading") {
//   main();
// } else {
//   document.addEventListener("DOMContentLoaded", main, false);
// }
