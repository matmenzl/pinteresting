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
