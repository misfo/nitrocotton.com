function showVote(shirtId, upOrDown) {
  $('thumb_'+upOrDown+'_'+shirtId).addClassName('voted');
  $('thumb_'+(upOrDown == "up" ? "down" : "up")+'_'+shirtId).removeClassName('voted');
  if (upOrDown == 'down') $('tee_tile_'+shirtId).setOpacity(0.4);
}

document.observe("dom:loaded", function() {
  $$('.tee_tile').each(function(tile) {
    tile.observe('mouseover', function() {
      this.down('.tee_thumb').setOpacity(0.1);
      this.down('.tee_info').show();
    });
    tile.observe('mouseout', function() {
      this.down('.tee_info').hide();
      this.down('.tee_thumb').setOpacity(1);
    });
  });
});
