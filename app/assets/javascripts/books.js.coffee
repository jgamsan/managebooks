# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in webreserva.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#extra_tokens_ids_').click ->
    model = parseInt($('#services tr:eq(2) td:eq(3)').text())
    colValues = 0;
    $("#services tr").filter(':has(:checkbox:checked)').each ->
      colValues += parseInt($(this).find('td:eq(3)').text())
    $('#total').replaceWith(colValues + model)
