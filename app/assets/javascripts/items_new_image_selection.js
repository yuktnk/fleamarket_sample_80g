$(document).on("turbolinks:load", function(){
  //DataTransferオブジェクトで、データを格納する箱を作る
  var dataBox = new DataTransfer();
  //querySelectorでfile_fieldを取得
  var file_field = document.querySelector('input[type=file]')

  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  // 既に使われているindexを除外
  lastIndex = $('.js-file:last').data('index');
  fileIndex.splice(0, lastIndex);

  // 削除するためのチェックボックスを非表示
  $('.hidden-destroy').hide();
  $('#img-file').hide();
  $('.add-img-file').hide();

  // 10枚登録されていた場合にボックスを消す
  $(document).ready(function(){
    var image_num = $('.item-image').length
    if (image_num==10){
      $('#image-box__container').css('display', 'none')
    }
  });



  //（新規投稿用）fileが選択された時に発火するイベント
  $('#img-file').change(function(){
    //選択したfileのオブジェクトをpropで取得
    var files = $('input[type="file"]').prop('files')[0];
    $.each(this.files, function(i, file){
      //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
      var fileReader = new FileReader();
      //DataTransferオブジェクトに対して、fileを追加
      dataBox.items.add(file)
      //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に代入
      file_field.files = dataBox.files
      var num = $('.item-image').length + 1 + i
      fileReader.readAsDataURL(file);
      //画像が10枚になったら超えたらドロップボックスを削除する
      if (num == 10){
        $('#image-box__container').css('display', 'none')   
      }
      //読み込みが完了すると、srcにfileのURLを格納
      fileReader.onloadend = function() {
        var src = fileReader.result
        var html= `<div class='item-image' data-image="${file.name}">
                    <div class=' item-image__content'>
                      <div class='item-image__content--icon'>
                        <img src=${src} width="116" height="116" >
                      </div>
                    </div>
                    <div class='item-image__operetion'>
                      <div class='item-image__operetion--delete'>削除</div>
                    </div>
                  </div>`
        //image_box__container要素の前にhtmlを差し込む
        $('#image-box__container').before(html);
      };
      //image-box__containerのクラスを変更し、CSSでドロップボックスの大きさを変えてやる。
      $('#image-box__container').attr('class', `item-num-${num}`)
    });
  });


  //（編集画面用）追加用のinputに画像を追加した際に発火するイベント
  $(document).on('change', '.add-img-file', function(e) {
    const targetIndex = $(this).parent().data('index'); // カスタムデータ属性の取得（0, 1, 2, 3とかとか）

    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
    
    // 画像用のinputを生成する関数
    const buildFileField = (num)=> {
      const html = `<div class="js-file" data-index="${num}" id="preview-${num}">
                      <input type="file" name="item[item_images_attributes][${num}][src]"
                      id="add-img-file-${num}" class="add-img-file">
                    </div>`;
      return html;
    }
    // labelボタンを生成する関数
    const buildLabel = (num)=> {
      const html = `<label class="hidden-label-${num}" for="add-img-file-${num}">
                      <i class="fas fa-camera"></i>
                        <br>
                      クリックしてファイルをアップロード
                    </label>`;
      return html;
    }

    
    
    
    const buildPreview = (num)=> {
      var html= `<div class='item-image' id="${num-1}" data-image="${file.name}">
                      <div class=' item-image__content'>
                        <div class='item-image__content--icon'>
                          <img src=${blobUrl} width="116" height="116" >
                        </div>
                      </div>
                      <div class='item-image__operetion'>
                        <div class='item-image__operetion--deleteAdd'>削除</div>
                      </div>
                    </div>`
      return html;
    }
    $('.js-file_group').append(buildFileField(fileIndex[0]));
    $('.UploadBtn').html(buildLabel(fileIndex[0]));
    //image_box__container要素の前にhtmlを差し込む
    $('#image-box__container').before(buildPreview(fileIndex[0]));
    console.log((fileIndex[0]));
    // shift()で先頭の要素を取り除く
    fileIndex.shift();
    // 末尾の数に1足した数を追加する
    fileIndex.push(fileIndex[fileIndex.length - 1] + 1);

    


    // //image-box__containerのクラスを変更し、CSSでドロップボックスの大きさを変えてやる。
    // console.log(fileIndex[0]-1);
    // $('#image-box__container').attr('class', `item-num-${fileIndex[0]-1}`)

    //image-box__containerクラスをもつdivタグのクラスを削除のたびに変更
    var num = $('.item-image').length
    $('#image-box__container').show()
    //image-box__containerのクラスを変更し、CSSでドロップボックスの大きさを変える。
    $('#image-box__container').attr('class', `item-num-${num}`)
    if (num==10){
      $('#image-box__container').css('display', 'none')
    }
    $('.add-img-file').hide();
  });




  //（新規投稿用）JSで追加した削除ボタンをクリックすると発火するイベント
  $(document).on("click", '.item-image__operetion--delete', function(){
    //削除を押されたプレビュー要素を取得
    var target_image = $(this).parent().parent()
    //削除を押されたプレビューimageのfile名を取得
    var target_name = $(target_image).data('image')
    console.log(file_field.files);
    console.log(file_field.files.length);
    //プレビューがひとつだけの場合、file_fieldをクリア
    if(file_field.files.length==1){
      //inputタグに入ったファイルを削除
      $('input[type=file]').val(null)
      dataBox.clearData();
    }else{
      //プレビューが複数の場合
      $.each(file_field.files, function(i,input){
        //削除を押された要素と一致した時、index番号に基づいてdataBoxに格納された要素を削除する
        if(input.name==target_name){
          console.log(i);
          console.log(dataBox.items);
          dataBox.items.remove(i) 
        }
      })
      //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に再度代入
      file_field.files = dataBox.files
    }
    //プレビューを削除
    target_image.remove()
    //image-box__containerクラスをもつdivタグのクラスを削除のたびに変更
    var num = $('.item-image').length
    $('#image-box__container').show()
    $('#image-box__container').attr('class', `item-num-${num}`)
  })



  //（編集画面用）投稿済みのプレビュー表示している商品の削除ボタンをクリックすると発火するイベント
  $(document).on("click", '.item-image__operetion--deleteHidden', function(){
    //削除を押されたプレビュー要素を取得
    var target_image = $(this).parent().parent();
    console.log(target_image);
    //削除を押されたプレビューimageのfile名を取得
    var target_id = $(target_image).attr('class');
    console.log(target_id);
    var target_image_file = $('input[value="'+target_id+'"][type=hidden]');
    console.log(target_image_file);
    const targetIndex = target_image.data('index');
    console.log(targetIndex);
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);
    
    
    //プレビューを削除
    target_image.remove()
    target_image_file.remove()
    //image-box__containerクラスをもつdivタグのクラスを削除のたびに変更
    var num = $('.item-image').length
    $('#image-box__container').show()
    $('#image-box__container').attr('class', `item-num-${num}`)
    if (num==10){
      $('#image-box__container').css('display', 'none')
    }
    
  })



  //（編集画面用）JSで追加した削除ボタンをクリックすると発火するイベント
  $(document).on("click", '.item-image__operetion--deleteAdd', function(){
    //削除を押されたプレビュー要素を取得
    var target_image = $(this).parent().parent()
    console.log(target_image);

    //削除を押されたプレビューimageのfile名を取得
    var target_id = $(target_image).attr('id');
    console.log(target_id);
    // var target_image_file = $('input[value="'+target_id+'"][type=hidden]');
    // console.log(target_image_file);
    // const targetIndex = target_image.data('index');
    // console.log(targetIndex);
    const aaaaa = "#preview-" + target_id
    console.log(aaaaa);
    //プレビューを削除
    target_image.remove()
    $(aaaaa).remove()
    //image-box__containerクラスをもつdivタグのクラスを削除のたびに変更
    var num = $('.item-image').length
    $('#image-box__container').show()
    //image-box__containerのクラスを変更し、CSSでドロップボックスの大きさを変える。
    $('#image-box__container').attr('class', `item-num-${num}`)
    if (num==10){
      $('#image-box__container').css('display', 'none')
    }
  })

});