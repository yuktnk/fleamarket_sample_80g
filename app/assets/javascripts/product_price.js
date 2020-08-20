
$(function(){    
  $('#product_price').on('input', function(){
    $(this).keyup(function(){
      var inputPrice = Number($(this).val());
      if(inputPrice >= 300 && inputPrice < 10000000){
        var fee = Math.floor(inputPrice * 0.1);
        var benefit = inputPrice - fee;
        $('#price_fee').text("¥" + fee.toLocaleString()),
        $('#price_benefit').text("¥" + benefit.toLocaleString())
      }else{
        $('#price_fee').html("ー");
        $('#price_benefit').html("ー");
      }
    });
  });
});



// 参考元コード
// $( document ).on( 'input', '#product_price', function(){
//   $("#product_price").keyup(function(){
//     var inputPrice = Number($(this).val());
//     if(inputPrice >= 300 && inputPrice < 10000000){
//       var fee = Math.floor(inputPrice * 0.1);
//       var benefit = inputPrice - fee;
//       $('#price_fee').text("¥" + fee.toLocaleString()),
//       $('#price_benefit').text("¥" + benefit.toLocaleString())
//     }else{
//       $('#price_fee').html("ー");
//       $('#price_benefit').html("ー");
//     }
//   });
// });