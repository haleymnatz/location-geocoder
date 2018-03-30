function validateZip(event) {
  var zipField = document.forms.address_form.elements.zip_field;
  var zipCode = zipField.value;
  if (!zipCode.match(/^\d+$/)) {
    alert("Please use only digits for the zip code.");
    zipField.focus();
    return false;
  }
}
