$(document).ready(function() {
  window.nestedFormEvents.insertFields = function(content, assoc, link) {
    return $(link).closest('form').find('#answers').append($(content));
  }
});
