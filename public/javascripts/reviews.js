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
					$.ajax({ url: "/reviews/new_submit_subject", context: document.body, type: 'POST', data: 'subject_id='+selected['subject_id'], success: function() {
					}});
				} else if ($("#step")[0].value == "subject") {
					$.ajax({ url: "/reviews/new_submit_initiator", context: document.body, type: 'POST', data: 'initiator_id='+selected['initiator_id'], success: function() {
					//$.ajax({ url: "/reviews/new_details", context: document.body, success: function() {
					}});
				} else if ($("#step")[0].value == "details") {
                                	$(this).dialog('close');
				}
                        }
                }
        });     
}

var selected = [];
//selected['qs_id'] = null;
//selected['person_id'] = null;
//selected['subject_id'] = null;
function new_review_select_choice(prefix, qs_id) {
	if (selected[prefix + "id"] != null) {
		$("#" + prefix + selected[prefix + "id"] + "_row a").removeClass('selected');
	}
	console.log("set selected['"+prefix+"id'] = " + qs_id);
	selected[prefix + "id"] = qs_id;
	$("#" + prefix + selected[prefix + "id"] + "_row a").addClass('selected');
}
