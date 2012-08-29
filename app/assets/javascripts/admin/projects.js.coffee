$ ->
  $.ajaxCount = 0
  $("#projects_per_page").change ->
    params["projects_per_page"] = $(this).val()
    document.location = $(this).attr("rel") + "?" + $.param(params)
  
  # Partnership Filter
  $("div.poptions li a").toggle (->
    $("#filter_all").removeClass "selected"
    $(this).addClass "selected"
  ), ->
    $(this).removeClass "selected"
    $("#filter_all").addClass "selected"  if $("div.poptions li a.selected").length is 0

  $("#mvmtselector").click ->
    $("div#mvmtfilter").toggle()
    $(this).toggleClass "active"

  $("#filter_all").click ->
    $(this).addClass "selected"
    $("[data-partner]").removeClass "selected"

  $("#filter_button").click ->
    $(this).attr "disabled", true
    filters = {}
    partners = []
    $("div.poptions li a.selected[data-partner]").each (i) ->
      partners[i] = $(this).attr("data-partner")
    filters["partners"] = partners  if partners.length > 0
    filters["closed"] = true  if $("#closed:checked")[0]?
    document.location = $(this).attr("rel") + "?" + $.param(filters)

  # END Partnership Filter


  # Find as you type

  search_prompt = "Type here to filter"
  $(".search").each(->
    if $(this).val() is ""
      $(this).val search_prompt
      $(this).addClass "prompt"
  ).focus(->
    if $(this).val() is search_prompt
      $(this).val ""
      $(this).removeClass "prompt"
  ).blur(->
    if $(this).val() is ""
      $(this).val search_prompt
      $(this).addClass "prompt"
  ).keyup ->
    # Clear the other search fields
    $(".search").not(this).val ""
    param = $(this).attr("name")
    params[param] = $(this).val()
    $("#spinner_" + param).show()
    $.ajaxCount++
    $.ajax
      url: $(this).attr("rel") + "?" + $.param(params)
      dataType: "script"
      complete: ->
        $.ajaxCount--
        $("#spinner_" + param).hide()  if $.ajaxCount is 0
  	# END Find as you type
  


  # Row hover actions
  $(".project_row").live("mouseenter", ->
    $(".rollovershow", this).show()
  ).live "mouseleave", ->
    $(".rollovershow", this).hide()
  # END row hover actions
  
  # Edit checkboxes
  $(".checkvertical input[type=checkbox]").click ->
    $(this).closest("div").toggleClass "selected"
  # END Edit checkboxes
  
  # Person Info
  $("a.person").live "click", ->
    id = $(this).attr("data-id")
    if id?
      name = $(this).html()
      dom = "leader_details" + id
      unless $("#" + dom)[0]?
        $("body").append "<div id=\"" + dom + "\" title=\"" + name + "\"><img alt=\"Spinner\" class=\"spinner\" id=\"spinner_" + id + "\" src=\"spinner.gif\" style=\"\" /></div>"
        $.ajax
          dataType: "script"
          type: "GET"
          url: "/admin/people/" + id
      $("#person_" + id + "_form").hide()
      $("#person_" + id + "_info").show()
      buttons =
        Close: ->
          $(this).dialog "close"
        "Edit information": ->
          $("#person_" + id + "_info").hide()
          $("#person_" + id + "_form").show()
          $("#leader_details" + id).dialog "option",
            height: 520
            buttons: {}


      # If this is a leader, provide the option to change the leader
      leader_link = $(this).closest(".leader_cell").find(".edit-leader")
      if leader_link[0]?
        project_id = leader_link.attr("data-id")
        leader = leader_link.attr("data-leader")
        if project_id and leader
          buttons["Change Leader"] = ->
            $(this).dialog "close"
            $("#edit_leader_" + project_id + leader).click()
      $("#" + dom).dialog
        resizable: false
        height: 300
        width: 400
        modal: true
        buttons: buttons
      false

  
  # $('.edit_person_link').live('click', function() {
  # 
  # 	return false
  # });
  $(".cancel_edit_person_link").live "click", ->
    id = $(this).attr("data-id")
    $("#leader_details" + id).dialog "close"
    false

  $("#update_person_form").live "ajax:loading", ->
    $("#person_" + id + "_form").html "<img src=\"spinner.gif\" />"

  # END Leader Info


  $("td:not(.sidebar) > .leader_cell").live("mouseenter", ->
    $(".buttons", this).show()
  ).live "mouseleave", ->
    $(".buttons", this).hide()

  # Edit Leader
  $("a.edit-leader").live "click", ->
    id = $(this).attr("data-id")
    name = $(this).attr("data-name")
    $("#add_leader_form").hide()
    $("#leader_search_form").show()
    $("#leader_search_name").val ""
    $("#leader_search_results").hide()
    el = $("#leader_search")
    el.attr "title", name
    form = $("#leader_search_form")
    $("#leader_search_project_id").val id
    $("#leader_search_type").val $(this).attr("data-leader")
    el.dialog
      resizable: false
      height: 427
      width: 400
      modal: true
      buttons:
        Cancel: ->
          $(this).dialog "destroy"
    false

  $("#leader_search_name").autocomplete source: (request, response) ->
    
    # var term = request.term;
    $("#spinner_leader_search").show()
    $.ajax
      url: form.attr("action")
      data: form.serialize()
      dataType: "script"
      type: "POST"
      success: (data) ->
        $("#leader_search_results").html data
        $("#leader_search_results").show()

      complete: ->
        $("#spinner_leader_search").hide()

    response []

  
  # Update leader
  $("a.new_leader").live "click", ->
    $("#leader_search_name").val ""
    $("#leader_search_person_id").val $(this).attr("data-id")
    form = $("#create_leader_form")
    $.ajax
      url: form.attr("action")
      data: form.serialize()
      dataType: "script"
      type: "POST"

    $("#leader_search_results").html "<img src=\"spinner.gif\" />"
    false

  # END Edit Leader
  
  # Add new person as leader
  $("#create_leader_form").bind "ajax:before", ->
    $("#spinner_leader_add").show()

  # END Add new person as leader
  
  
  # Send project email
  $("#email_form").submit ->
    message = ""
    message += "You need to put in at least one email address to send this email to.<br />"  if $.trim($("#to").val()) is ""
    message += "Please provide a subject for your email.<br />"  if $.trim($("#subject").val()) is ""
    unless message is ""
      $("#dialog-confirm").attr "title", "Slow down :)"
      $("#dialog-confirm-message").html message
      $("#dialog-confirm").dialog
        modal: true
        buttons:
          Ok: ->
            $(this).dialog "close"
      false

  $("#changeyear").click ->
    $("#year_list").toggle()
    false

  $("#sp_project_start_date").datepicker()
  $("#sp_project_end_date").datepicker()
  $("#readmoreless").click ->
    $("#" + $(this).attr("rel")).toggleClass "showall", 500
    $(this).text (if $(this).text() is "Read More" then "Read Less" else "Read More")
    false

  $("#group").change ->
    $("#to").val emails[$("#group").val()]
    if $.trim($("#to").val()) is ""
      $("#dialog-confirm").attr "title", "Check your project year"
      year = $("#changeyear").html()
      $("#dialog-confirm-message").html "There aren't any people in the group you selected for the " + year + " project year. Try choosing a different year from the dropdown, or manually enter some email addresses."
      $("#dialog-confirm").dialog
        modal: true
        buttons:
          Ok: ->
            $(this).dialog "close"
