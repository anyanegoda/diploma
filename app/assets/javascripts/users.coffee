# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
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
  $('body').on 'click', '.btn-remove-subject-up', ->
    subject_id = $(this).data('subject-id')
    this_btn = $(this)
    $.ajax
      url: "/remove_subject"
      type: "POST"
      data: { subject_id: subject_id }
      success: (data) ->
        parent = this_btn.parents('tr')
        parent.remove()
      error: (data) ->
        text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
        $('#error .error-text').html(text_error)
        $('#error').addClass('visible')
  $('body').on 'click', '.btn-remove-extramular-subject', ->
    extramular_subject_id = $(this).data('extramular-subject-id')
    this_btn = $(this)
    $.ajax
      url: "/remove_extramular_subject"
      type: "POST"
      data: { extramular_subject_id: extramular_subject_id }
      success: (data) ->
        parent = this_btn.parents('tr')
        parent.find('.user-initials').text('')
        parent.find('.btn-remove-extramular-subject').removeClass('btn-remove-extramular-subject').addClass('extramular-subject-select-add')
        parent_clone = parent.clone()
        parent.remove()
        $('#empty-disciplines-ext tbody').append(parent_clone)
      error: (data) ->
        text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
        $('#error .error-text').html(text_error)
        $('#error').addClass('visible')
  $('body').on 'click', '.btn-remove-extramular-subject-up', ->
    extramular_subject_id = $(this).data('extramular-subject-id')
    this_btn = $(this)
    $.ajax
      url: "/remove_extramular_subject"
      type: "POST"
      data: { extramular_subject_id: extramular_subject_id }
      success: (data) ->
        parent = this_btn.parents('tr')
        parent.remove()
      error: (data) ->
        text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
        $('#error .error-text').html(text_error)
        $('#error').addClass('visible')
  $('.checkbox').click ->
    id = $(this).data('user-id')
    text_make = 'Удалить права администратора'
    text_revoke = 'Дать права администратора'
    if $(this).is(':checked')
      $.ajax
        url: "/user/make_admin"
        type: "POST"
        data: { id: id }
        success: (data) ->
          debugger
          $('p.switch-text').text(text_make)
        error: (data) ->
          alert('error')
    else
      $.ajax
        url: "/user/revoke_admin"
        type: "POST"
        data: { id: id }
        success: (data) ->
          debugger
          $('p.switch-text').text(text_revoke)
        error: (data) ->
          alert('error')
