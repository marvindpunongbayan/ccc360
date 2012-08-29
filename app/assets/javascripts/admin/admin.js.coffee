$ ->
  $(".inlinetip a.prompt").click ->
    $(this).hide()
    $(this).next(".tip").show()
    false
  $(".inlinetip a.hidetip").click ->
    div = $(this).closest(".inlinetip")
    $(".tip", div).hide()
    $(".prompt", div).show()
    false
  $("#tabs").tabs
    ajaxOptions:
      error: (xhr, status, index, anchor) ->
        $(anchor.hash).html "Couldn't load this tab. We'll try to fix this as soon as possible."
    cache: true
    spinner: "<img src=\"spinner_dark.gif\" />"
    load: ->
      $(".spinner").html ""
  $(".pagination a").live "click", (e) ->
    $(this).callRemote()
    e.preventDefault()
