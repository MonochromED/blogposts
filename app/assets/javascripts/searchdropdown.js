//Toggles search area drop down
$(document).ready(function(){
  $('#search_icon').click(function(){
      $('#search_bar_area').slideToggle('slow');
      //When search area drop down triggered, highlights search bar area to type into.
      $('#search_text_bar').focus();
  });


});
