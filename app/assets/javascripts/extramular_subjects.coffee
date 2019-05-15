# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('body').on 'click', '.extramular-subject-select-add', ->
    subject_id = $(this).data('ext-sub-id')
    this_btn = $(this)
    $.ajax
      url: "/insert_extramural_user_id"
      type: "POST"
      data: { subject_id: subject_id }
      success: (data) ->
        parent = this_btn.parents("tr")
        parent.find('.user-initials').text data
        parent.find('.extramular-subject-select-add').removeClass('extramular-subject-select-add').addClass('btn-remove-extramular-subject')
        parent_clone = parent.clone()
        parent.remove()
        $('#choosed-disciplines-ext tbody').append(parent_clone)
      error: (data) ->
        text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
        $('#error .error-text').html(text_error)
        $('#error').addClass('visible')
  $('.error-close').on 'click', ->
    $('#error').removeClass('visible')
  $('body').on 'click', '.user-select-change-ext', ->
    user_id = $(this).parents('.change-user-ext').find('.select-user-ext').val() * 1
    current_user_id = $(this).parents('.change-user-ext').data('current-user-id')
    subject_id = $(this).parents('.change-user-ext').find('select option').data('subject-id-ext')
    this_btn = $(this)
    $.ajax
      url: "/change_ext_user_id"
      type: "POST"
      data: { change_user: {user_id: user_id, subject_id: subject_id }}
      success: (data) ->
        parent = this_btn.parents("tr")
        parent.find('.user-initials-ext').text data
        parent.find('.extramular-subject-select-add').removeClass('extramular-subject-select-add').addClass('btn-remove-extramular-subject')
        parent_clone = parent.clone()
        parent.remove()
        if user_id == current_user_id
          $('#choosed-disciplines-ext tbody').append(parent_clone)
        else
          $('#busy-disciplines-ext tbody').append(parent_clone)
      error: (data) ->
        text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
        $('#error .error-text').html(text_error)
        $('#error').addClass('visible')
  $('body').on 'click', '.user-select-change-ext-up', ->
    user_id = $(this).parents('.change-user-ext').find('.select-user-ext').val() * 1
    current_user_id = $(this).parents('.change-user-ext').data('current-user-id')
    subject_id = $(this).parents('.change-user-ext').find('select option').data('subject-id-ext')
    this_btn = $(this)
    $.ajax
      url: "/change_ext_user_id"
      type: "POST"
      data: { change_user: {user_id: user_id, subject_id: subject_id }}
      success: (data) ->
        parent = this_btn.parents("tr")
        if user_id != current_user_id
          parent.remove()
      error: (data) ->
        text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
        $('#error .error-text').html(text_error)
        $('#error').addClass('visible')
