function show_reviewers_dialog() {
        $("#new_reviewer_dialog").dialog({
                resizable: false,
                width:600,
                height:400,
                modal: true,
                buttons: {
                        Done: function() {
                                $(this).dialog('close');
                        }/*,
                        Add: function() {
                                $(this).dialog('close');
                                confirm = el.attr('data-confirm')
                                el.removeAttr('data-confirm');
                                el.click();
                                el.attr('data-confirm', confirm);
                        }*/
                }
        });     
}

function new_review_dialog() {
        $("#new_review_dialog").dialog({
                resizable: false,
                width:600,
                height:400,
                modal: true,
                buttons: {
		/*
                        Cancel: function() {
                                $(this).dialog('close');
                        },
			*/
                        Next: function() {
				if ($("#step")[0].value == "form") {
					$.ajax({ url: "/reviews/new_submit_form", context: document.body, type: 'POST', data: 'question_sheet_id='+selected['qs_id'], success: function() {
					}});
				} else if ($("#step")[0].value == "person") {
					$.ajax({ url: "/reviews/new_submit_person", context: document.body, type: 'POST', data: 'person_id='+selected['person_id'], success: function() {
					}});
				} else if ($("#step")[0].value == "requester") {
					$.ajax({ url: "/reviews/new_details", context: document.body, success: function() {
					}});
				} else if ($("#step")[0].value == "details") {
                                	$(this).dialog('close');
				}
                        }
                }
        });     
}

var selected = [];
selected['qs_id'] = null;
selected['person_id'] = null;
selected['initiator_id'] = null;
function new_review_select_choice(prefix, qs_id) {
	if (selected[prefix] != null) {
		$("#" + prefix + selected[prefix] + "_row a").removeClass('selected');
	}
	selected[prefix] = qs_id;
	$("#" + prefix + selected[prefix] + "_row a").addClass('selected');
}
