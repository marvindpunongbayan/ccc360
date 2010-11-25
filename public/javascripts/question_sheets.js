function change_questionnaire_type_dialog() {
        $("#change_question_type_dialog").dialog({
                resizable: false,
                width:600,
                height:425,
                modal: true,
                buttons: {
                        Save: function() {
                        },
                        Cancel: function() {
				$(this).dialog('close');
                        }
                }
        });
	$("#change_question_type_dialog").show();
}

