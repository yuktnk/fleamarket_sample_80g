$(function(){
  //入力時のイベント    
  $('.explanationField').on('input', function(){
      //文字数を取得
      var cnt = $(this).val().length +"/1000";

      //現在の文字数を表示
      $('.now_cnt').text(cnt);

      // if(cnt > 0 && 1000 > cnt){
      //     //1文字以上かつ1000文字以内の場合はボタンを有効化
      //     $('.buttonBlue').prop('disabled', false);
      //     $('.Main__center__container__productExplanationCounter').removeClass('cnt_danger');
      // }else{
      //     //0文字または1000文字を超える場合はボタンを無効化＆赤字→灰色？
      //     $('.buttonBlue').prop('disabled', true);
      //     $('.Main__center__container__productExplanationCounter').addClass('cnt_danger');
      // }
  });
  
  // リロード時に初期文字列が入っていた時の対策
  $('.explanationField').trigger('input');
  
  // ボタンクリック時 実運用時はsubmit送信などを行うと思います
  // $('.buttonBlue').click(function(){
  //     alert('送信できる状態です！');
  // });
});


