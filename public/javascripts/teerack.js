function showVote(shirtId, upOrDown) {
  $('thumb_'+upOrDown+'_'+shirtId).addClassName('voted');
  $('thumb_'+(upOrDown == "up" ? "down" : "up")+'_'+shirtId).removeClassName('voted');
  if (upOrDown == 'down') $('tee_tile_'+shirtId).setOpacity(0.4);
}
