function showLinkFavouritedNotice(link) {
  var favourited = !!$(link).data("favourited");
  // get the text of the .title element
  // that we find among the children of link
  var name = $(link).find('.title').text();
  var message = favourited ?
                name + " was added to favourites" :
                name + " was removed from favourites";
  var flash = $("<div></div>").addClass('flash').addClass('notice').html(message);
  $(flash).appendTo('#flash-container');
  setTimeout(function() {
    $(flash).fadeOut();
  }, 3000);
}

function addFavouritesHandler() {
  $(".star.solid").click(function(event) {  
    // get the link this star belongs to
    var link = $(this).parent();
    // get a boolean value for 'favourited'
    // double negation casts any value to boolean
    var favourited = !!$(link).data("favourited");
    // decide what the opacity is going to be
    var newOpacity = favourited ? 0 : 1;
    // toggle the 'favourited' variable on the link element
    $(link).data("favourited", !favourited);    
    // perform the animation
    $(this).animate({opacity: newOpacity}, 1000);
    showLinkFavouritedNotice(link);
  });
}

$(function() {
  addFavouritesHandler();
})
