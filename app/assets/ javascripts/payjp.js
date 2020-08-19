document.addEventListener(
  "DOMContentLoaded",
  (e) => {
    if (document.getElementById("token_submit") != null) {
      //token_submitというidがnullの場合、下記コードを実行しない
      Payjp.setPublicKey("pk_test_0cab5a53778ebb4cb97de57f"); //公開鍵
      let btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得される
      btn.addEventListener("click", (e) => {
        //ボタンが押されたときに作動する
        e.preventDefault(); //ボタンを一旦無効化しとる
        // カード情報の作成
        let card = {
          number: document.getElementById("card_number").value,
          cvc: document.getElementById("cvc").value,
          exp_month: document.getElementById("exp_month").value,
          exp_year: document.getElementById("exp_year").value,
        }; //入力されたデータを取得します。
        Payjp.createToken(card, (status, response) => {
          if (status === 200) {
            //成功した場合、200になるらしい
            $("#card_number").removeAttr("name");
            $("#cvc").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#card_token").append(
              $('<input type= "hidden" name= "payjp-token">').val(response.id)
            ); //取得したトークンを送信できる状態にします
            document.inputForm.submit();
            alert("登録が完了しました"); //確認用
          } else {
            alert("カード情報が正しくありません。"); //確認用
          }
        });
      });
    }
  },
  false
);
