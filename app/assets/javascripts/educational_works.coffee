# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  quantity_hash = {}
  $(".quantity-e").change ->
    quantity = $(this).val()
    time = $(this).data("time")
    temp = quantity * time
    $(this).parents("tr").find('.new-quantity-e').text temp
    name = $(this).data("name-input")
    quantity_hash[name] = temp
  $('.add-quantity-e').on 'click', ->
    $.ajax
      url: "/add_educational_work"
      type: "POST"
      data: {quantity_hash: quantity_hash}
      success: (data) ->
        debugger
        alert("Ok")
      error: (data) ->
        alert("Not ok")
