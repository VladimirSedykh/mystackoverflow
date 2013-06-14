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
	# Search form mactions.
	form = $('#search_form')
	box = $('#search_res')	
	input = $('#q')

	input.keyup ->
		url = form.serialize() 		
		$.ajax
 			type: "GET"
 			dataType: "json"
 			url: '/questions/search?' + url
 			dataType: 'json'
 			success: (data) ->	
 				output = ''			
 				$.each(data, -> 
 					el = $(this)[0]					
 					output += '<a href="/questions/' + el.id + '"">' + el.title + '</a>'	
 				)				
 				box.html(output).show()

 	form.mouseleave ->
 			box.slideUp() if $('#search_res').html() 
 	input.click ->
 		box.slideDown() if $('#search_res').html() 

 	$('.clear_btn').click ->
 		box.html('')
 		input.val('')
 		false