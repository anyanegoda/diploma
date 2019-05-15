# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
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
