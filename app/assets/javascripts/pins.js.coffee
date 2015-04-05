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

  $(".email-share").click ->
    swal
      title: "Share this pin!"
      text: "Type users email to send him this pin details:"
      type: "input"
      showCancelButton: true
      closeOnConfirm: false
      animation: "slide-from-top"
    , (inputValue) ->
      return false  if inputValue is false
      if inputValue is ""
        swal.showInputError "You need to write an email address!"
        return false
      swal "Nice!", "This pin details will be sent to: " + inputValue + ". \n Thank You for using deinenachbarn.ch!", "success"
      $("form#email-pin input#email").val(inputValue)
      $("form#email-pin").submit()

  $("#pin-type select").change ->
    if this.value is "Offer"
      $("#pin-status").removeClass("hidden")
    else
      $("#pin-status").addClass("hidden")

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
    markers = handler.addMarkers(map_markers)

    # createSidebar json_array
    handler.bounds.extendWith markers
    handler.fitMapToBounds()