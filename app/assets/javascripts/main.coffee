getParameterByName = (name) ->
  name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]")
  regex = new RegExp("[\\?&]" + name + "=([^&#]*)")
  results = regex.exec(location.search)
  (if not results? then "" else decodeURIComponent(results[1].replace(/\+/g, " ")))

$ ->
	if $(".tag-data").length > 0
	  split = (val) ->
	    val.split /,\s*/
	  extractLast = (term) ->
	    split(term).pop()
	  taglist = $(".tag-data").html().split("")
	  res = ""
	  $.each taglist, (i, v) ->
	    res += (if (v is " ") then "" else v)

	  availableTags = res.split("|")

	  $("#post_tagslist").bind("keydown", (event) ->
	    event.preventDefault()  if event.keyCode is $.ui.keyCode.TAB and $(this).data("ui-autocomplete").menu.active
	  ).autocomplete
	    minLength: 0
	    source: (request, response) ->
	      
	      # delegate back to autocomplete, but extract the last term
	      response $.ui.autocomplete.filter(availableTags, extractLast(request.term))

	    focus: ->
	      
	      # prevent value inserted on focus
	      false

	    select: (event, ui) ->
	      terms = split(@value)
	      
	      # remove the current input
	      terms.pop()
	      
	      # add the selected item
	      terms.push ui.item.value
	      
	      # add placeholder to get the comma-and-space at the end
	      terms.push ""
	      @value = terms.join(", ")
	      false

$ ->

	# Tabs active class.
	_addTabClass = (v) ->
		tabs = $('#tabs a').removeClass('youarehere')
		$('#tab-' + v).addClass('youarehere')	


	tab_val = getParameterByName('tab')
	tab_data = [ "all", 'my', 'today', 'week', 'month', 'fre']

	$.each tab_data, (i, v) ->
		if tab_val == v
			_addTabClass(v)

$ ->
	# Ajax for post votes.
	$.ajax
	  type: "POST"
	  url: "http://localhost:3000/questions/1"
	  data    : { posts : { votes : '100' } },
	  success: (data) ->
	    alert data + " DATA HERE" 
	  	
            
