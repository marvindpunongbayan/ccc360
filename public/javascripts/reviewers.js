function setup_search_autocomplete {
        $("#reviewer_search_name").autocomplete({
                source: function(request, response) {
                        // var term = request.term;
                        $.ajax({url: "/reviewers/search",
                                data: { source: "reviewer", name: $("#reviewer_search_name")[0].value },
                                dataType: "script",
                                type: "GET",
                                complete: function() { $("#reviewer_search_name").removeClass("ui-autocomplete-loading") }
                        });
                }
        });
};

