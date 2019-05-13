# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  current_url = location.pathname
  active_menu = $(".menu-link[href='"+current_url+"']")
  if active_menu.length
    active_menu.addClass('active')
  $('.burger').on 'click', ->
    $('.menu').addClass('visible')
  $('.close-menu').on 'click', ->
    $('.menu').removeClass('visible')
