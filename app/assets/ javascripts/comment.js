$(function(){
  function buildHTML(comment){
    let html = `<ul>
                  <li class="CommentList__user">
                    ${comment.user_name}
                    <span>さん</span>
                  </li>
                  <li class="CommentList__text">
                    ${comment.text}
                  </li>
                  <li class="CommentList__delete">
                    <a rel="nofollow" data-method="delete" href="/items/${comment.item_id}/comments/${comment.comment_id}"><i class="fa fa-trash"></i>
                  </a></li>
                </ul>`
    return html;
  }
  $('#NewComment').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    console.log(this)
    let url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      let html = buildHTML(data);
      console.log(html);
      $('.CommentList').append(html);
      $('.TextBox').val('');
      $('.SubmitAJAX').prop('disabled', false);
    })
    .fail(function(){
      alert('error');
    })
  })
})