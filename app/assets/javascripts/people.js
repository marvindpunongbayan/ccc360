$(document).ready(function() {
  /*
	$('#admin').change(function() { $.ajax({ 
		url: $(this).attr('data-url'), 
		data: { admin: $("#admin")[0].checked, _method: "PUT" },
		type: "POST"
	}) })
  */

	$('#flags input').change(function(i) { 
    $.ajax({ 
      url: $(this).attr('data-url'), 
      data: { access: $(this).attr('data-access'), value: i.target.checked, _method: "PUT" },
      type: "POST"
    })
  })

  $('#jobstatusflag select').change(function(i) {
    $.ajax({ 
      data: { access: 'jobstatus', value: $(this).val(), _method: "PUT" },
      type: "POST"
    })
  })

  $('#jobtitleflag select').change(function(i) {
    $.ajax({ 
      data: { access: 'jobtitle', value: $(this).val(), _method: "PUT" },
      type: "POST"
    })
  })

	$("#person_name").autocomplete({
		source: function(request, response) {
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
