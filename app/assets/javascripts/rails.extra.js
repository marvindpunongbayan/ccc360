(function($) {
	if ($('#dialog-confirm')[0] == null) {
		$('body').append('<div id="dialog-confirm" style="display:none" title="Are you sure?"><p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span><span id="dialog-confirm-message"></span></p></div>');
	}
	// Enable sortable items
	$(function() {
		setUpJsHelpers();
	});			
})(jQuery);

function setUpSortables() {
	$('[data-sortable]').sortable({axis:'y', 
																  dropOnEmpty:false, 
																  update: function(event, ui) {
																		sortable = this;
																		$.ajax({data:$(this).sortable('serialize',{key:sortable.id + '[]'}),
																						complete: function(request) {$(sortable).effect('highlight')}, 
																						success:function(request){$('#errors').html(request)}, 
																						type:'put', 
																						url: $(sortable).attr('data-sortable-url')
																					 })
																		}
	});
	$('[data-sortable][data-sortable-handle]').each(function() {
		handle = $(this).attr('data-sortable-handle');
		$(this).sortable("option", "handle", handle);
	});
}

function setUpCalendars() {
	$('[data-calendar]').datepicker({changeYear:true,
																	 yearRange: '1975:c+5'})
}

function setUpJsHelpers() {
	
		// ==================
		// Sortable
		setUpSortables();
		// ==================
		
		// ==================
		// Calendar
		setUpCalendars();
  	// ==================
}