function new_reminder_dialog() {
        $("#reminders_dialog").dialog({
		title: "New Reminder/Note",
                resizable: false,
                width:600,
                height:425,
                modal: true,
                buttons: {
                        Create: function() {
				$.ajax({ url: "/reminders",
					 type: "POST",
					 data: $("form.new_reminder").serialize()
				});
                        },
                        Cancel: function() {
				$(this).dialog('close');
                        }
                }
        });
	$("#reminders_dialog").show();
	$.ajax({
		url: "/reminders/new"
	});
}

function edit_reminders_dialog(reminder_id) {
        $("#reminders_dialog").dialog({
		title: "Edit Reminder/Note",
                resizable: false,
                width:600,
                height:425,
                modal: true,
                buttons: {
                        Save: function() {
				$.ajax({ url: "/reminders/" + reminder_id,
					 type: "POST",
					 data: $("form.edit_reminder").serialize()+"&_method=PUT"
				});
                        },
                        Cancel: function() {
				$(this).dialog('close');
                        }
                }
        });
	$("#reminders_dialog").show();
	$.ajax({
		url: "/reminders/" + reminder_id + "/edit"
	});
}

function update_send_email_defaults() {
	$("#reminder_send_email")[0].checked = true;
}
