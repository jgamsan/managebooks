# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#timepicker').timepicker()

$ ->
  $('#timepicker1').timepicker()

$ ->
  $.datepicker.setDefaults($.datepicker.regional['es'])
  $('#init_date').datepicker()
  $('#finish_date').datepicker()

