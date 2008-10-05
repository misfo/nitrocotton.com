function showVote(shirtId, upOrDown) {
  $('thumb_'+upOrDown+'_'+shirtId).addClassName('voted');
  $('thumb_'+(upOrDown == "up" ? "down" : "up")+'_'+shirtId).removeClassName('voted');
  $('tee_tile_'+shirtId).setOpacity(0.4);
}
