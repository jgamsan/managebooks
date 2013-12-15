# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in webreserva.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
gm_init = ->
  gm_center = new google.maps.LatLng(43.204785, -7.795082)
  gm_map_type = google.maps.MapTypeId.ROADMAP
  map_options = {center: gm_center, zoom: 17, mapTypeId: gm_map_type}
  new google.maps.Map(document.getElementById("map_canvas"),map_options);

load_markers = (map) ->
  callback = (data) -> show_on_map(data,map)
  $.get '/stores/list_available.json', {}, callback, 'json'

show_on_map = (data,map) ->
  marcas = []
  j = 0
  for j of data
    myLatlng = new google.maps.LatLng(data[j].latitude,data[j].longitude)
    options = {position: myLatlng, map: map, title: data[j].name, icon:data[j].icon}
    marcas.push new google.maps.Marker(options)
    marker = marcas[j]
    bindInfoWindow(marker, map, infowindow, data[j].information)
    google.maps.event.addListener marker, 'mouseout', ->
      infowindow.close()
    bounds.extend(marker.position)
    marcas[j].setMap(map)
    j++
  map.fitBounds(bounds)

bindInfoWindow = (marker, map, infowindow, html) ->
  google.maps.event.addListener marker, 'mouseover', ->
    infowindow.setContent(html)
    infowindow.open(map, marker)

infowindow = new google.maps.InfoWindow
  content: ''

bounds = new google.maps.LatLngBounds()

$ ->
  map = gm_init()
  load_markers(map)


# $ ->
#   $(".replace_markers").click ->
#     result = $(this).attr("href")
#     $.getJSON result + ".json", (data)->
#       Gmaps.map.replaceMarkers(data)

# $ ->
#   Gmaps.map.infobox = (boxText)->
#     content: boxText
#     ,disableAutoPan: false
#     ,maxWidth: 0
#     ,pixelOffset: new google.maps.Size(-140, 0)
#     ,zIndex: null
#     ,boxStyle:
#       background: "url('http://google-maps-utility-library-v3.googlecode.com/svn/tags/infobox/1.1.5/examples/tipbox.gif') no-repeat"
#       ,opacity: 0.75
#       ,width: "280px"
#     ,closeBoxMargin: "10px 2px 2px 2px"
#     ,closeBoxURL: "http://www.google.com/intl/en_us/mapfiles/close.gif"
#     ,infoBoxClearance: new google.maps.Size(1, 1)
#     ,isHidden: false
#     ,pane: "floatPane"
#     ,enableEventPropagation: false

$ ->
  $('#MiBanner').carousel('cycle')
$ ->
  $('#InfoBanner').carousel('cycle')
$ ->
  $('#MiTab').tab('show')

$ ->
  $('#menu1').dropdown()
$ ->
  $('#login').dropdown()

$ ->
  $('.dropdown-menu').find('form').click (e)->
    e.stopPropagation()

