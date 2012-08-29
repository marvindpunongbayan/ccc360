show_reviewers_dialog = ->
  $("#new_reviewer_dialog").dialog
    resizable: false
    width: 600
    height: 425
    modal: true
    buttons:
      Done: ->
        $(this).dialog "close"

#,
#                        Add: function() {
#                                $(this).dialog('close');
#                                confirm = el.attr('data-confirm')
#                                el.removeAttr('data-confirm');
#                                el.click();
#                                el.attr('data-confirm', confirm);
#                        }
notify_not_selected = ->
  $("#dialog-message").remove()
  $("#new_review_dialog + .ui-dialog-buttonpane button").after "<span id='dialog-message'></span>"
  if $("#step")[0].value is "form"
    msg = "Please select a form before continuing."
  else if $("#step")[0].value is "subject"
    msg = "Please select a person to review before continuing."
  else msg = "Please select who will administrate the review before continuing."  if $("#step")[0].value is "initiator"
  $("#dialog-message").html msg
next_step = ->
  if $("#step")[0].value is "form"
    unless selected["qs_id"]?
      notify_not_selected()
      return
    
    # $.ajax({ url: "/reviews/new_submit_form", context: document.body, type: 'POST', data: 'question_sheet_id='+selected['qs_id']+'&authenticity_token='+encodeURIComponent(AUTH_TOKEN), success: function() {
    $.ajax
      url: "/reviews/new_submit_form"
      context: document.body
      type: "POST"
      data: "question_sheet_id=" + selected["qs_id"]
      success: ->

  else if $("#step")[0].value is "subject"
    unless selected["subject_id"]?
      notify_not_selected()
      return
    $.ajax
      url: "/reviews/new_submit_subject"
      context: document.body
      type: "POST"
      data: "subject_id=" + selected["subject_id"]
      success: ->

  
  # $.ajax({ url: "/reviews/new_submit_subject", context: document.body, type: 'POST', data: 'subject_id='+selected['subject_id']+'&authenticity_token='+encodeURIComponent(AUTH_TOKEN), success: function() { }});
  else if $("#step")[0].value is "initiator"
    unless selected["initiator_id"]?
      notify_not_selected()
      return
    
    # $.ajax({ url: "/reviews/new_submit_initiator", context: document.body, type: 'POST', data: 'initiator_id='+selected['initiator_id']+'&authenticity_token='+encodeURIComponent(AUTH_TOKEN), success: function() {
    $.ajax
      url: "/reviews/new_submit_initiator"
      context: document.body
      type: "POST"
      data: "initiator_id=" + selected["initiator_id"]
      success: ->

  
  #$.ajax({ url: "/reviews/new_details", context: document.body, success: function() {
  else if $("#step")[0].value is "details"
    $("#new_review").submit()
    $(this).dialog "close"
previous_step = ->
  if $("#step")[0].value is "form"

  else if $("#step")[0].value is "subject"
    $.ajax
      url: "/reviews/new"
      context: document.body
      type: "GET"

    selected["qs_id"] = null
  else if $("#step")[0].value is "initiator"
    $.ajax
      url: "/reviews/new_subject"
      context: document.body
      type: "GET"

    selected["subject_id"] = null
  else if $("#step")[0].value is "details"
    $.ajax
      url: "/reviews/new_initiator"
      context: document.body
      type: "GET"

    selected["initiator_id"] = null
new_review_dialog = ->
  $("#team").remove() # ajax search breaks without this
  $("#new_review_dialog").dialog
    resizable: false
    width: 600
    height: 425
    modal: true
    buttons:
      
      #
      #                        Cancel: function() {
      #                                $(this).dialog('close');
      #                        },
      #			
      Next: ->
        next_step()

      Back: ->
        previous_step()

  $("span:contains('Back')").parent().hide()
  $("span:contains('Back')").parent().css "float", "left"
edit_review_dialog = ->
  $("#edit_review_dialog").dialog
    resizable: false
    width: 600
    height: 425
    modal: true
    buttons:
      
      #
      #                        Cancel: function() {
      #                                $(this).dialog('close');
      #                        },
      #			
      Save: ->
        $("form.edit_review").submit()


#selected['qs_id'] = null;
#selected['person_id'] = null;
#selected['subject_id'] = null;
new_review_select_choice = (prefix, qs_id) ->
  if selected[prefix + "id"] is qs_id and (new Date() - lastClickTime < 1000)
    
    # make clicking twice within 1 second go next
    next_step()
  else $("#" + prefix + selected[prefix + "id"] + "_row a").removeClass "selected"  if selected[prefix + "id"]?
  lastClickTime = new Date()
  selected[prefix + "id"] = qs_id
  $("#" + prefix + selected[prefix + "id"] + "_row a").addClass "selected"
setup_search_autocomplete = (prefix, review_id) ->
  $("#" + prefix + "_search_name").autocomplete source: (request, response) ->
    
    # var term = request.term;
    $.ajax
      url: "/reviews" + ((if prefix is "reviewer" then "/" + review_id + "/reviewers" else "")) + "/search"
      data:
        source: prefix
        name: $("#" + prefix + "_search_name")[0].value

      dataType: "script"
      type: "GET"
      complete: ->
        $("#" + prefix + "_search_name").removeClass "ui-autocomplete-loading"


show_new_person_dialog = ->
  $("#new_person_dialog").dialog
    resizable: false
    width: 600
    height: 425
    modal: true
    buttons:
      "Create person and add them as a reviewer": ->
        $("form.new_person").submit()

      Cancel: ->
        $(this).dialog "close"

selected = []
lastClickTime = undefined