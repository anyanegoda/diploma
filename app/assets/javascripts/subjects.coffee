$(document).on 'turbolinks:load', ->
  $('.subject-select-add').on 'click', ->
    #subject_id = $('#select-subject :selected').data 'value'
    subject_id = $('#select-subject').val()
    $.ajax
      url: "/insert_user_id"
      type: "POST"
      data: { subject_id: subject_id }
      success: (data) ->
        debugger
        $("#select-subject option[value="+data+"]").remove()
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
