var addVote = function(likeOrDislike, button) {
  var id = button.id;
  var vote = button.className;
  var count = button.parentElement.parentElement.getElementsByClassName("vote")[0]
  var rating = parseInt(count.innerHTML) + likeOrDislike;
  var message = button.parentElement.parentElement.getElementsByClassName('message')[0].getElementsByTagName('span')[0]

  var request = $.ajax({
    method: 'POST',
    data: { _method: 'PATCH', up_or_down: vote },
    url: '/api/v1/votes/' + id
  });

  request.done(function() {
    $(count)[0].innerHTML=(rating)
    if (message.textContent == "") {
      $(button).hide();
      if (likeOrDislike == 1) {
        message.textContent=('You liked this review!')
      } else {
        message.textContent=('You disliked this review!')
      }
    } else if (message.textContent == "You liked this review!") {
      message.textContent=('')
      button.parentElement.parentElement.getElementsByClassName('up')[0].style.display = "block";
    } else if (message.textContent == "You disliked this review!") {
      message.textContent=('')
      button.parentElement.parentElement.getElementsByClassName('down')[0].style.display = "block";
    };
  });
};
