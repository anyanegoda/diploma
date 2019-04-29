# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('#select-names').change ->
    name_id = $('#select-names :selected').val()
    $('#work_name_work_id').val(name_id)

  $('.tablinks').on 'click', ->
    workType = $(this).data('work-type')
    $('.tablinks').removeClass('active')
    $(this).addClass('active')
    $('.tabcontent').hide()
    $("#"+workType+"").fadeIn()
