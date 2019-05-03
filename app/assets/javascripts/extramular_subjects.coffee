# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('.extramural-subject-select-add').on 'click', ->
    #subject_id = $('#select-subject :selected').data 'value'
    subject_id = $('#select-extramural-subject').val()
    debugger
    $.ajax
      url: "/insert_extramural_user_id"
      type: "POST"
      data: { subject_id: subject_id }
      success: (data) ->
        debugger
        $("#select-extramural-subject option[value="+data+"]").remove()
      error: (data) ->
        text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
        $('#error .error-text').html(text_error)
        $('#error').addClass('visible')
  $('.error-close').on 'click', ->
    $('#error').removeClass('visible')
