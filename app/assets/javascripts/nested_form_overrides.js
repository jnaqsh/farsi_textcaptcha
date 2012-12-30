$(document).ready(function() {
  window.nestedFormEvents.insertFields = function(content, assoc, link) {
    return $(link).closest('form').find('#answers').after($(content));
  }
});
