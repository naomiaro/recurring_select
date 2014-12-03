// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {

  $("#fake_model_recurring_rules").on('recurring_select:save', function(e, json) {
    alert(json.str);
  });

  $("#fake_model_recurring_rules").on('recurring_select:cancel', function(e) {
    alert("cancelled");
  });

});