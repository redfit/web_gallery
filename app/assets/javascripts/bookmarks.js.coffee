# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

ready = ->
  $('a[id*=mail]').tooltip()

  $(document)
    .on "click", 'a[id*="mail"]', ->
      list = $(@).parents('li')
      $('#mail_form').attr('action', list.data('url')+"/send_mail")
    .on "click", 'a[id*="modal"]', ->
      list = $(@).parents('li')
      $('#form').attr('action', list.data('url')).attr('method', 'put')
      $('#bookmark_title').val(list.data('title'))
      $('#bookmark_tag_list').val(list.data('tags'))

  $(document).on "click", '#submit-dialog', ->
    $("#form").submit()

  $(document)
    .on "ajax:success", '#form', ->
      $("#bookmarks").load("/bookmarks #bookmarks")
      $('#edit-modal').modal('hide')

  $(document)
    .on "ajax:success", 'a[id*="delete"]', ->
      $("#bookmarks").load("/bookmarks #bookmarks")

$(document).ready(ready)
$(document).on('page:load', ready)
