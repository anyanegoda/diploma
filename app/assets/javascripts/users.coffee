# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('.btn-remove-subject').on 'click', ->
    subject_id = $(this).parents('.subject').find('.subject-id').data('subject-id')
    this_btn = $(this)
    $.ajax
      url: "/remove_subject"
      type: "POST"
      data: { subject_id: subject_id }
      success: (data) ->
        this_btn.parents('.subject').remove()
      error: (data) ->
        text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
        $('#error .error-text').html(text_error)
        $('#error').addClass('visible')

  $('.btn-remove-extramular-subject').on 'click', ->
    extramular_subject_id = $(this).parents('.extramular-subject').find('.extramular-subject-id').data('extramular-subject-id')
    this_btn = $(this)
    debugger
    $.ajax
      url: "/remove_extramular_subject"
      type: "POST"
      data: { extramular_subject_id: extramular_subject_id }
      success: (data) ->
        this_btn.parents('.extramular-subject').remove()
      error: (data) ->
        text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
        $('#error .error-text').html(text_error)
        $('#error').addClass('visible')
