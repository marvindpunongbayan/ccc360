# Edit Leader
$("a.add-user").live "click", ->
  role = $(this).attr("data-role")
  type = $(this).attr("data-type")
  $("#add_user_form").hide()
  $("#user_form").show()
  $("#user_search_name").val ""
  el = $("#user_search")
  el.attr "title", "Add a new " + role
  $("#user_type").val type
  el.dialog
    resizable: false
    height: 427
    width: 400
    modal: true
    buttons:
      Cancel: ->
        $(this).dialog "destroy"
  false

$ ->
  $("#user_search_name").autocomplete source: (request, response) ->
    term = request.term
    url = "/admin/users/search?type=" + $("#user_type").val() + "&name=" + term
    $("#spinner_user_search").show()
    $.ajax
      url: url
      dataType: "script"
      type: "GET"
      complete: ->
        $("#spinner_user_search").hide()
    response []

  $("a.new_user").live "click", ->
    $("#user_search_name").val ""
    $("#user_search_person_id").val $(this).attr("data-id")
    form = $("#create_user_form")
    $.ajax
      url: form.attr("action")
      data: form.serialize()
      dataType: "script"
      type: "POST"
    $("#user_search_results").html "<img src=\"spinner.gif\" />"
    false
