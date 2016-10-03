// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
// var addVote = function(likeOrDislike, button) {
//   var id = button.id;
//   var vote = button.className;
//   var count = button.parentElement.parentElement.getElementsByClassName("vote")[0]
//   var rating = parseInt(count.innerHTML) + likeOrDislike;
//   var message = button.parentElement.parentElement.getElementsByClassName('message')[0].getElementsByTagName('span')[0]
//
//   var request = $.ajax({
//     method: 'POST',
//     data: { _method: 'PATCH', up_or_down: vote },
//     url: '/api/v1/votes/' + id
//   });
//
//   request.done(function() {
//     $(count)[0].innerHTML=(rating)
//     if (message.textContent == "") {
//       $(button).hide();
//       if (likeOrDislike == 1) {
//         message.textContent=('You liked this review!')
//       } else {
//         message.textContent=('You disliked this review!')
//       }
//     } else if (message.textContent == "You liked this review!") {
//       message.textContent=('')
//       button.parentElement.parentElement.getElementsByClassName('up')[0].style.display = "block";
//     } else if (message.textContent == "You disliked this review!") {
//       message.textContent=('')
//       button.parentElement.parentElement.getElementsByClassName('down')[0].style.display = "block";
//     };
//   });
// };

$(function() {
  $("input.up").click(function(event) {
    event.preventDefault();
    addVote(1, this);
  });
});

$(function() {
  $("input.down").click(function(event) {
    event.preventDefault();
    addVote(-1, this);
  });
});

function getParameterByName(name) {
  var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.search);
  return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
};

var search = getParameterByName('search')
if (search == null) {
  setInterval(function() {

    var request = $.ajax({
      method: 'GET',
      url: '/api/v1/teams'
    });

    request.done(function(data) {

      var page = getParameterByName('page');

      data.sort(function(a, b) {
        var locationA = a.location.toUpperCase();
        var locationB = b.location.toUpperCase();
        var nameA = a.name.toUpperCase();
        var nameB = b.name.toUpperCase();
        return ((locationA < locationB) || ((locationA == locationB) && (nameA < nameB))) ? -1 :
        ((locationA > locationB) || ((locationA == locationB) && (nameA > nameB))) ? 1 : 0;
      });

      var firstTeamIndex = 0;
      if (page != null) {
        firstTeamIndex = ((parseInt(page)-1) * 20)
      }

      var listLength = 20;
      if ((data.length - firstTeamIndex) < 20) {
        listLength = (data.length - firstTeamIndex);
      }

      $("#teams").empty();
      for (var i = firstTeamIndex; i < (firstTeamIndex + listLength); i++) {
        $("#teams").append("<li><a href='/teams/" + data[i].id + "'>"  + data[i].location + " " + data[i].name + " " + "(" + data[i].league + ")" + "</a></li>")
      }
    });
  }, 5000);
};
