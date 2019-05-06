# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('.extramular-subject-select-add').on 'click', ->
    subject_id = $(this).parents('.add-extramular-subject').data('ext-sub-id')
    add = $(this).parents('.add-extramular-subject')
    $.ajax
      url: "/insert_extramural_user_id"
      type: "POST"
      data: { subject_id: subject_id }
      success: (data) ->
        add.parents("tr").find('.user-initials-ext').text data
      error: (data) ->
        text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
        $('#error .error-text').html(text_error)
        $('#error').addClass('visible')
  $('.error-close').on 'click', ->
    $('#error').removeClass('visible')
  $('.user-select-change-ext').on 'click', ->
    user_id = $(this).parents('.change-user-ext').find('#select-user-ext').val()
    subject_id = $(this).parents('.change-user-ext').find('select option').data('subject-id-ext')
    change = $(this).parents('.change-user-ext')
    $.ajax
      url: "/change_ext_user_id"
      type: "POST"
      data: { change_user: {user_id: user_id, subject_id: subject_id }}
      success: (data) ->
        change.parents("tr").find('.user-initials-ext').text data
      error: (data) ->
        text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
        $('#error .error-text').html(text_error)
        $('#error').addClass('visible')
