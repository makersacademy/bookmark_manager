function addFavouritesHandler() {
  $(".star.solid").click(function(event) {
    $(this).animate({opacity: 1}, 1000);
  });
}

$(function() {
  addFavouritesHandler();
})
