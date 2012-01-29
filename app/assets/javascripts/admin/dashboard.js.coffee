# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('a[data-code]').click ->
    $('pre').toggle
      
      
$ ->
  $("#store_province").change ->
    province = $('select#store_province :selected').val()
    if province == ""
      province = 0
    $.get '/admin/stores/update_town_select/' + province, (data)->
      $("#addressTowns").html(data)
    return false
      
$ ->
  $("book_day").change ->
    fecha = $('input#book_day').val()
    $.get '/admin/books/update_day_selected/' + fecha, (data)->
      $("#freeIntervals").html(data)
