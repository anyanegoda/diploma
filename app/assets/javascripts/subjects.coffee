$(document).on 'turbolinks:load', ->
  $('.subject-select-add').on 'click', ->
    #subject_id = $('#select-subject :selected').data 'value'
    # subject_id = $('#select-subject').val()
    # $.ajax
    #   url: "/insert_user_id"
    #   type: "POST"
    #   data: { subject_id: subject_id }
    #   success: (data) ->
    #     $("#select-subject option[value="+data+"]").remove()
    #   error: (data) ->
    #     text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
    #     $('#error .error-text').html(text_error)
    #     $('#error').addClass('visible')
    subject_id = $(this).parents('.add-subject').data('sub-id')
    add = $(this).parents('.add-subject')
    debugger
    $.ajax
      url: "/insert_user_id"
      type: "POST"
      data: { subject_id: subject_id }
      success: (data) ->
        add.parents("tr").find('.user-initials').text data
      error: (data) ->
        text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
        $('#error .error-text').html(text_error)
        $('#error').addClass('visible')
  $('.error-close').on 'click', ->
    $('#error').removeClass('visible')
  $('.upload-file-btn').on 'click', ->
    input_file = $('#upload-file').val()
    $.ajax
      url: "/save_input_file"
      type: "POST"
      data: {input_file: input_file}
      success: (data) ->
        alert("Ok")
      error: (data) ->
        alert("Not ok")
  $('.user-select-change').on 'click', ->
    user_id = $(this).parents('.change-user').find('#select-user').val()
    subject_id = $(this).parents('.change-user').find('select option').data('subject-id')
    change = $(this).parents('.change-user')
    debugger
    $.ajax
      url: "/change_user_id"
      type: "POST"
      data: { change_user: {user_id: user_id, subject_id: subject_id }}
      success: (data) ->
        debugger
        change.parents("tr").find('.user-initials').text data
      error: (data) ->
        text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
        $('#error .error-text').html(text_error)
        $('#error').addClass('visible')
