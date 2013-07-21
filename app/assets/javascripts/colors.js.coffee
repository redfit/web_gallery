# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

ready = ->
  $("#help").on "click", ->
    $("body").chardinJs("start")

  canvas = document.getElementById("picker")
  return false  if not canvas or not canvas.getContext
  ctx = canvas.getContext("2d")
  popoverOptions =
    selector: ".color-pallet"
    container: "body"
    placement: "top"
    html: true

  # Imageオブジェクトを生成
  img = new Image()
  img.src = $(canvas).data("url")
  img.onload = ->

    # 画像を描画
    ctx.drawImage img, 0, 0
    imagedata = ctx.getImageData(0, 0, canvas.width, canvas.height).data
    canvas.onclick = (evt) ->
      offset = $("canvas").position()
      mouseX = parseInt(evt.clientX) - Math.floor(offset.left)
      mouseY = parseInt(evt.clientY) - Math.floor(offset.top)
      i = ((mouseY * canvas.width) + mouseX) * 4
      r = imagedata[i]
      g = imagedata[i + 1]
      b = imagedata[i + 2]
      a = imagedata[i + 3]
      $.ajax(
        url: location.href
        data:
          color:
            x: evt.clientX
            y: evt.clientY
            red: r
            green: g
            blue: b
            alpha: a
        type: "POST"
        dataType: "html"
      ).done( (html) ->
        $(html).popover(popoverOptions).hide().appendTo("#pick-list").fadeIn()
      )
  $(document).on("click", ".pick .icon-remove",  ->
    $(@).parents("li.pick").fadeOut  ->
      $(@).remove()
  ).on("click", ".pick",  ->
    offset = $("#picker").position()
    x = parseInt($(@).data("x"), 10) - 14
    y = parseInt($(@).data("y"), 10) - 7 # icon 14px
    icon = $("<i/>").addClass("icon-hand-right").css("position","absolute")
      .css("top","#{y}px").css("left","#{x}px").css("margin", "0").css("padding", "0")
    $(".icon-hand-right").remove()
    icon.appendTo($("#picker").parent())
    icon.effect("bounce", { direction: 'left', distance: 30, times: 5 }, 500)
  )
  $(".pick").popover popoverOptions

$(document).ready(ready)
$(document).on('page:load', ready)
