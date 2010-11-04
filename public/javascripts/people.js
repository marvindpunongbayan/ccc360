$(document).ready(function() {
	$('#admin').change(function() { $.ajax({ 
		url: $(this).attr('data-url'), 
		data: { admin: $("#admin")[0].checked, _method: "PUT" },
		type: "POST"
	}) })

	$("#person_name").autocomplete({
		source: function(request, response) {
			console.log("HERE");
			// var term = request.term;
			$.ajax({url: "/people/search",
				data: { name: $("#person_name")[0].value },
				dataType: "script",
				type: "GET",
				complete: function() { $("#person_name").removeClass("ui-autocomplete-loading") }
			});
		}
	});

});
