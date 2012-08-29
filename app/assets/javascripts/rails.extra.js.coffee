# Enable sortable items
setUpSortables = ->
  $("[data-sortable]").sortable
    axis: "y"
    dropOnEmpty: false
    update: (event, ui) ->
      sortable = this
      $.ajax
        data: $(this).sortable("serialize",
          key: sortable.id + "[]"
        )
        complete: (request) ->
          $(sortable).effect "highlight"
        success: (request) ->
          $("#errors").html request
        type: "put"
        url: $(sortable).attr("data-sortable-url")
  $("[data-sortable][data-sortable-handle]").each ->
    handle = $(this).attr("data-sortable-handle")
    $(this).sortable "option", "handle", handle

setUpCalendars = ->
  $("[data-calendar]").datepicker
    changeYear: true
    yearRange: "1975:c+5"

setUpJsHelpers = ->
  # ==================
  # Sortable
  setUpSortables()
  # ==================
  #  Calendar
  setUpCalendars()

(($) ->
  $("body").append "<div id=\"dialog-confirm\" style=\"display:none\" title=\"Are you sure?\"><p><span class=\"ui-icon ui-icon-alert\" style=\"float:left; margin:0 7px 20px 0;\"></span><span id=\"dialog-confirm-message\"></span></p></div>"  unless $("#dialog-confirm")[0]?
  $ ->
    setUpJsHelpers()

) jQuery
