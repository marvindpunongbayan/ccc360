function change_questionnaire_type_dialog(question_sheet_id) {
        $("#change_question_type_dialog").dialog({
                resizable: false,
                width:600,
                height:425,
                modal: true,
                buttons: {
                        Save: function() {
				$.ajax({ url: "/question_sheet_pr_infos/" + question_sheet_id,
					 type: "POST",
					 data: $("#edit_question_sheet_pr_info").serialize()
				});
                        },
                        Cancel: function() {
				$(this).dialog('close');
                        }
                }
        });
	$("#change_question_type_dialog").show();
	$.ajax({
		url: "/question_sheet_pr_infos/" + question_sheet_id + "/edit.js"
	});
}

