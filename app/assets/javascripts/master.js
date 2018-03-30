function validateZip() {
  $('form').submit(function(e) {
    var zipField = $('#zip_field');
    if (!zipField.val().match(/^\d+$/)) {
      alert("Please use only digits for the zip code.");
      zipField.focus();
      return false;
    }
  });
}


$(function(){
  validateZip();
});
