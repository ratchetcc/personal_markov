# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

list = ["banner1","banner2","banner3","banner4","banner5","banner6","banner7","banner8","banner9"]
path = "assets/" + list[Math.floor(Math.random() * list.length)] + ".jpeg"

$(document).ready ->
	$("#banner").css "background", "url(#{path})"