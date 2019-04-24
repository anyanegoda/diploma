# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  quantity_hash_em = {}
  $(".quantity-em").change ->
    quantity_em = $(this).val()
    time_em = $(this).data("time-em")
    temp_em = quantity_em * time_em
    $(this).parents("tr").find('.new-quantity-em').text temp_em
    name_em = $(this).data("name-input-em")
    # debugger
    quantity_hash_em[name_em] = temp_em
  $('.add-quantity-em').on 'click', ->
    $.ajax
      url: "/add_educational_and_methodical_work"
      type: "POST"
      data: {quantity_hash_em: quantity_hash_em}
      success: (data) ->
        debugger
        alert("Ok")
      error: (data) ->
        alert("Not ok")
