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


$ ->
  # Search for tags input.
  input = $('#search_tags')
  box = $('.tag-suggestions')
  tag = $('._tag')
  added = {}
  reserved = {}
  deleted = {}

  $.each($('.post-tag'), ->
    id = $(this).attr('id')
    added[id] = id
    reserved[id] = id
  )

  # remove tag from added tags.
  removeTag = () ->
    $('.delete-tag').on "click", ->
      el = $(this).parent()
      id = el.attr('id')
      deleted[id] = id;
      delete added[id]
      $('#tags_' + id).remove()
      el.remove()

  removeTag()

  input.keyup ->
    url = $(this).serialize()

    # if q is not empty check.
    if url.split('').length > 2
      $.ajax
        type: 'GET'
        url : '/questions/search_tag?' + url
        success: (data) ->
          data =  JSON.parse(data)
          output = ''
          $.each(data, ->
            el = $(this)[0]
            output += '<div class="_tag" id="' + el.id + '" name="' + el.name +
                   '"><div class="post-tag">' + el.name + '</div>' +
                   '<p>' + el.about + '</p>' +
                   '<div class="more-info"><a href="/tags">learn more</a></div>' +
                   '</div>'
          )
          box.html(output).show()

          # Append searched tag to the list of tags.
          $('._tag').click ->
            el = $(this)
            id = el.attr('id')
            name = el.attr('name')

            if added[id] != id
              box.hide()
              $('.posted-tags').append('<span class="post-tag" id="' + id + '">' + name + '<span class="delete-tag" title="' + name + '"></span></span>')

              # For edit method:  if reserved[id] != id.
              if reserved[id] != id
                $('#new-question-form form').append('<input id="tags_' + id + '" name="tags[]" type="hidden" value="' + id + '">')

              delete deleted[id]
              added[id] = id
              removeTag()
    else
      box.slideUp()

    input.click ->
      box.slideDown() if box.html()
    input.focusout ->
      box.slideUp()

    console.log deleted