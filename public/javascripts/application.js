$(function() {
  $(document).ajaxSend(function(event, request, settings) {
    if (typeof(AUTH_TOKEN) == "undefined") return;
    settings.data = settings.data || "";
    settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
  });

  $(".pic").mouseover(function() {
    $(".tee_overlay", this).show();
  }).mouseout(function() {
    $(".tee_overlay", this).hide();
  });

  $(".thumbs a").click(function() {
    $("img", this).attr('src', "/images/progress.gif");
    var thumbsUp = $(this).hasClass('thumbs_up');
    var link = this;
    $.post($(this).attr('href') + '.js', {vote: (thumbsUp ? 1 : -1)}, function () {
      $("img", link).attr('src', "/images/thumbs_"+(thumbsUp ? "up" : "down")+".png");
      $(link).siblings("a").removeClass('voted');
      $(link).addClass('voted');
    });
    return false;
  });
  if (typeof(initializeVotes) != "undefined") initializeVotes();
});
