# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('#pins').imagesLoaded ->
		$('#pins').masonry
			itemSelector: '.box'
			isFitWidth: true

  $(".dropdown-menu li a").click ->
    $(this).parents(".btn-group").find(".selection").text $(this).text()

  $("#full-text-search").click ->
    $("form#search-form input").attr("name", "q[description_cont]")
    $("form#search-form input").attr("placeholder", "E.g. 'Car Rent'")

  $("#location-search").click ->
    $("form#search-form input").attr("name", "search")
    $("form#search-form input").attr("placeholder", "E.g. 'Eiffel Tower, Paris, FR'")

  createSidebarLi = (json) ->
    "<li><a>" + json.name + "</a></li>"
  bindLiToMarker = ($li, marker) ->
    $li.on "click", ->
      handler.getMap().setZoom 14
      marker.setMap handler.getMap()
      marker.panTo()
      google.maps.event.trigger marker.getServiceObject(), "click"
  createSidebar = (json_array) ->
    _.each json_array, (json) ->
      $li = $(createSidebarLi(json))
      $li.appendTo "#sidebar_container"
      bindLiToMarker $li, json.marker
  handler = Gmaps.build("Google")
  handler.buildMap
    internal:
      id: "sidebar_builder"
  , ->
    console.log map_markers
    markers = handler.addMarkers(map_markers)

    # createSidebar json_array
    handler.bounds.extendWith markers
    handler.fitMapToBounds()