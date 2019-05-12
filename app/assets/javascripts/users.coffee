# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('body').on 'click', '.btn-remove-subject', ->
    subject_id = $(this).data('subject-id')
    this_btn = $(this)
    $.ajax
      url: "/remove_subject"
      type: "POST"
      data: { subject_id: subject_id }
      success: (data) ->
        parent = this_btn.parents('tr')
        parent.find('.user-initials').text('')
        parent.find('.btn-remove-subject').removeClass('btn-remove-subject').addClass('subject-select-add')
        parent_clone = parent.clone()
        parent.remove()
        $('#empty-disciplines tbody').append(parent_clone)
      error: (data) ->
        text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
        $('#error .error-text').html(text_error)
        $('#error').addClass('visible')

  $('body').on 'click', '.btn-remove-extramular-subject', ->
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
