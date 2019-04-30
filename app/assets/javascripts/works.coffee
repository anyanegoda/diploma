# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('#select-names').change ->
    name_id = $('#select-names :selected').val()
    $('#work_name_work_id').val(name_id)

  $('.tablinks').on 'click', ->
    workType = $(this).data('work-type')
    $('.tablinks').removeClass('active')
    $(this).addClass('active')
    $('.tabcontent').hide()
    $("#"+workType+"").fadeIn()

  quantity_hash_em = {}
  $(".quantity-em").change ->
    quantity = $(this).val()
    time = $(this).data("time")
    temp = quantity * time
    $(this).parents("tr").find('.new-quantity-em').text temp
    name = $(this).data("name-input")
    quantity_hash_em[name] = temp
  $('.add-quantity-em').on 'click', ->
    $.ajax
      url: "/add_educational_and_methodical_work"
      type: "POST"
      data: {quantity_hash_em: quantity_hash_em}
      success: (data) ->
        alert("Ok")
      error: (data) ->
        text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
        $('#error .error-text').html(text_error)
        $('#error').addClass('visible')

  quantity_hash_r = {}
  $(".quantity-r").change ->
    quantity = $(this).val()
    time = $(this).data("time")
    temp = quantity * time
    $(this).parents("tr").find('.new-quantity-r').text temp
    name = $(this).data("name-input")
    quantity_hash_r[name] = temp
  $('.add-quantity-r').on 'click', ->
    $.ajax
      url: "/add_research_work"
      type: "POST"
      data: {quantity_hash_r: quantity_hash_r}
      success: (data) ->
        alert("Ok")
      error: (data) ->
        text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
        $('#error .error-text').html(text_error)
        $('#error').addClass('visible')

  quantity_hash_om = {}
  $(".quantity-om").change ->
    quantity = $(this).val()
    time = $(this).data("time")
    temp = quantity * time
    $(this).parents("tr").find('.new-quantity-om').text temp
    name = $(this).data("name-input")
    quantity_hash_om[name] = temp
  $('.add-quantity-om').on 'click', ->
    $.ajax
      url: "/add_organizational_and_methodical_work"
      type: "POST"
      data: {quantity_hash_om: quantity_hash_om}
      success: (data) ->
        alert("Ok")
      error: (data) ->
        text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
        $('#error .error-text').html(text_error)
        $('#error').addClass('visible')

  quantity_hash_e = {}
  $(".quantity-e").change ->
    quantity = $(this).val()
    time = $(this).data("time")
    temp = quantity * time
    $(this).parents("tr").find('.new-quantity-e').text temp
    name = $(this).data("name-input")
    quantity_hash_e[name] = temp
  $('.add-quantity-e').on 'click', ->
    $.ajax
      url: "/add_educational_work"
      type: "POST"
      data: {quantity_hash_e: quantity_hash_e}
      success: (data) ->
        alert("Ok")
      error: (data) ->
        text_error = "Проблемы с записью в БД. Перезагрузите страницу и попробуйте снова."
        debugger
        $('#error .error-text').html(text_error)
        $('#error').addClass('visible')

  $('.error-close').on 'click', ->
    $('#error').removeClass('visible')
