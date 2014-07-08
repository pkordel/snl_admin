$(document).ready(function() {

  $(".encode").click(function(event) {
    var target = $(event.target);
    selector = target.attr("data-encode-selector");
    input = $(selector);
    value = input.val() || "";
    input.val(encodeURIComponent(value));
    return false;
  });

  $(".decode").click(function(event) {
    var target = $(event.target);
    selector = target.attr("data-decode-selector");
    input = $(selector);
    value = input.val() || "";
    input.val(decodeURIComponent(value));
    return false;
  });

});