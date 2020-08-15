$(function() {
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category) {
    let html = `<option value="${category.id}">${category.category}</option>`;
    // let html = `<option value="${category.category}" data-category="${category.id}">${category.category}</option>`;
    return html;
  }
  // 子カテゴリーの表示作成
  function appendChildrenBox(insertHTML) {
    let childSelectHtml = '';
    childSelectHtml = `<div class='selectWrap__added' id='children_wrapper'>
                        <div class='selectWrapBox'>
                          <select id="child_category" name="item[category_id]" class="select">
                            <option value="">---</option>
                            ${insertHTML}
                          </select>
                        </div>
                      </div>`;
    $('.Main__center__container__categoryWrapper').append(childSelectHtml);
  }
  // 孫カテゴリーの表示作成
  function appendGrandchildrenBox(insertHTML) {
    let grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='selectWrap__added' id= 'grandchildren_wrapper'>
                              <div class='selectWrapBox'>
                                <select id="grandchild_category" name="item[category_id]" class="select">
                                  <option value="">---</option>
                                  ${insertHTML}
                                </select>
                              </div>
                            </div>`;
    $('.Main__center__container__categoryWrapper').append(grandchildSelectHtml);
  }
  // 親カテゴリー選択後のイベント
  $('#item_category_id').on('change', function() {
  // $('#parent_category').on('change', function() {
    let parentId = document.getElementById('item_category_id').value; //選択された親カテゴリーの名前を取得
    // let parentCategory = document.getElementById('parent_category').value; //選択された親カテゴリーの名前を取得
    if (parentId != ""){ //親カテゴリーが初期値でないことを確認
    // if (parentCategory != "選択してください"){ //親カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/items/get_category_children/',
        // url: 'get_category_children',
        type: 'GET',
        data: { parent_id: parentId },
        dataType: 'json'
      })
      .done(function(children) {
        $('#children_wrapper').remove(); //親が変更された時、子以下を削除する
        $('#grandchildren_wrapper').remove();
        $('#size_wrapper').remove();
        // $('#brand_wrapper').remove();
        let insertHTML = '';
        children.forEach(function(child) {
          insertHTML += appendOption(child);
        });
        appendChildrenBox(insertHTML);
      })
      .fail(function() {
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除する
      $('#grandchildren_wrapper').remove();
      $('#size_wrapper').remove();
      // $('#brand_wrapper').remove();
    }
  });
  // 子カテゴリー選択後のイベント
  $('.Main__center__container__categoryWrapper').on('change', '#child_category', function() {
    let childId = document.getElementById('child_category').value; //選択された子カテゴリーのidを取得する
    // let childId = $('#child_category option:selected').data('category'); //選択された子カテゴリーのidを取得する
    if (childId != "" && childId != 46 && childId != 74 && childId != 134 && childId != 142 && childId != 147 && childId != 150 && childId != 158){ //子カテゴリーが初期値でないことを確認
    // if (childId != "選択してください"){ //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/items/get_category_grandchildren/',
        // url: 'get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren) {
        // console.log(grandchildren)
        // if (grandchildren.length != 0) {
          $('#grandchildren_wrapper').remove(); //子が変更された時、孫以下を削除する
          $('#size_wrapper').remove();
          // $('#brand_wrapper').remove();
          let insertHTML = '';
          grandchildren.forEach(function(grandchild) {
            insertHTML += appendOption(grandchild);
          });
          appendGrandchildrenBox(insertHTML);
        // }
      })
      .fail(function() {
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchildren_wrapper').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
      $('#size_wrapper').remove();
      // $('#brand_wrapper').remove();
    }
  });
  // サイズセレクトボックスのオプションを作成
  function appendSizeOption(size) {
    let html = `<option value="${size.id}">${size.size}</option>`;
    // let html = `<option value="${size.size}">${size.size}</option>`;
    return html;
  }
  // サイズ・ブランド入力欄の表示作成
  function appendSizeBox(insertHTML) {
    let sizeSelectHtml = '';
    sizeSelectHtml = `<div class="listing-product-detail__size" id= 'size_wrapper'>
                        <label class="Main__center__container__productCategory" for="サイズ">サイズ</label>
                        <span class='Main__center__container__required'>必須</span>
                        <div class='selectWrap__added--size'>
                          <div class='selectWrapBox'>
                            <select id="size" name="item[size_id]" class="select">
                              <option value="">---</option>
                              ${insertHTML}
                            <select>
                          </div>
                        </div>
                      </div>`;
    $('.Main__center__container__categoryWrapper').append(sizeSelectHtml);
  }
  // 孫カテゴリ選択後のイベント
  $('.Main__center__container__categoryWrapper').on('change', '#grandchild_category', function() {
    let grandchildId = document.getElementById('grandchild_category').value; //選択された孫カテゴリのidを取得
    // let grandchildId = $('#grandchild_category option:selected').data('category'); //選択された孫カテゴリのidを取得
    if (grandchildId != "---"){ //孫カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/items/get_size',
        // url: 'get_size',
        type: 'GET',
        data: { grandchild_id: grandchildId },
        dataType: 'json'
      })
      .done(function(sizes) {
        console.log(sizes)
        $('#size_wrapper').remove(); //孫が変更された時、サイズ欄以下を削除する
        // $('#brand_wrapper').remove();
        if (sizes.length != 0) {
          let insertHTML = '';
          sizes.forEach(function(size) {
            insertHTML += appendSizeOption(size);
          });
          appendSizeBox(insertHTML);
        }
      })
      .fail(function() {
        alert('サイズ取得に失敗しました')
      })
    }else{
      $('#size_wrapper').remove(); //孫カテゴリが初期値になった時、サイズ欄以下を削除する
      // $('#brand_wrapper').remove();
    }
  });
});