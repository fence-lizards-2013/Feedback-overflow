var Upvote = {
  init: function()  {
    $('.upvote a').on('ajax:success', this.addUpvote);
  },
  addUpvote: function(e, data) {
    if (data.redirect) return window.location = data.redirect
    $(this).parent().siblings('.upvote_count').text(data.count);
    $(this).closest('span').toggleClass('upvoted');
  }
}

$(document).ready(function() {
  Upvote.init();
});
