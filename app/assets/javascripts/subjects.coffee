$ ->
  $('body').on 'click', '.subject-select-add', ->
    subject_id = $(this).data('subject-id')
    this_btn = $(this)
    $.ajax
      url: "/insert_user_id"
      type: "POST"
      data: { subject_id: subject_id }
      success: (data) ->
        parent = this_btn.parents("tr")
        parent.find('.user-initials').text data
        parent.find('.subject-select-add').removeClass('subject-select-add').addClass('btn-remove-subject')
        parent_clone = parent.clone()
        parent.remove()
        $('#choosed-disciplines tbody').append(parent_clone)
      error: (data) ->
        text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
        $('#error .error-text').html(text_error)
        $('#error').addClass('visible')
  $('.error-close').on 'click', ->
    $('#error').removeClass('visible')
  $('body').on 'click', '.user-select-change', ->
    user_id = $(this).parents('.change-user').find('.select-user').val() * 1
    current_user_id = $(this).parents('.change-user').data('current-user-id')
    subject_id = $(this).parents('.change-user').find('select option').data('subject-id')
    this_btn = $(this)
    $.ajax
      url: "/change_user_id"
      type: "POST"
      data: { change_user: {user_id: user_id, subject_id: subject_id }}
      success: (data) ->
        parent = this_btn.parents("tr")
        parent.find('.user-initials').text data
        parent.find('.subject-select-add').removeClass('subject-select-add').addClass('btn-remove-subject')
        parent_clone = parent.clone()
        parent.remove()
        if user_id == current_user_id
          $('#choosed-disciplines tbody').append(parent_clone)
        else
          $('#busy-disciplines tbody').append(parent_clone)
      error: (data) ->
        text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
        $('#error .error-text').html(text_error)
        $('#error').addClass('visible')
  $('body').on 'click', '.user-select-change-up', ->
    user_id = $(this).parents('.change-user').find('.select-user').val() * 1
    current_user_id = $(this).parents('.change-user').data('current-user-id')
    subject_id = $(this).parents('.change-user').find('select option').data('subject-id')
    this_btn = $(this)
    $.ajax
      url: "/change_user_id"
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
