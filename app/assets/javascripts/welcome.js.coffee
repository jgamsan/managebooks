# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in webreserva.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".replace_markers").click ->
    result = $(this).attr("href")
    $.getJSON result + ".json", (data)->
      Gmaps.map.replaceMarkers(data)

$ ->
  Gmaps.map.infobox = (boxText)->
    content: boxText
    ,disableAutoPan: false
    ,maxWidth: 0
    ,pixelOffset: new google.maps.Size(-140, 0)
    ,zIndex: null
    ,boxStyle:
      background: "url('http://google-maps-utility-library-v3.googlecode.com/svn/tags/infobox/1.1.5/examples/tipbox.gif') no-repeat"
      ,opacity: 0.75
      ,width: "280px"
    ,closeBoxMargin: "10px 2px 2px 2px"
    ,closeBoxURL: "http://www.google.com/intl/en_us/mapfiles/close.gif"
    ,infoBoxClearance: new google.maps.Size(1, 1)
    ,isHidden: false
    ,pane: "floatPane"
    ,enableEventPropagation: false
