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
    $.post($(this).attr('href') + '.js', {vote: ($(this).hasClass('thumbs_up') ? 1 : -1)});
    $(this).siblings("a").removeClass('voted');
    $(this).addClass('voted');
    return false;
  });
  if (typeof(initializeVotes) != "undefined") initializeVotes();
});
