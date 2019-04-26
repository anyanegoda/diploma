# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('#select-names').change ->
    name_id = $('#select-names :selected').val()
    $('#work_name_work_id').val(name_id)
    debugger

  openWork = (evt, workName) ->
    i = undefined
    tabcontent = undefined
    tablinks = undefined
    tabcontent = document.getElementsByClassName('tabcontent')
    i = 0
    while i < tabcontent.length
      tabcontent[i].style.display = 'none'
      i++
    tablinks = document.getElementsByClassName('tablinks')
    i = 0
    while i < tablinks.length
      tablinks[i].className = tablinks[i].className.replace(' active', '')
      i++
    document.getElementById(workName).style.display = 'block'
    evt.currentTarget.className += ' active'
    return
