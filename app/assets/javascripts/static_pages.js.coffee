# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
results = [] 

replaceAt = (string, index, new_value) ->
  string.substring(0, index) + new_value + " "+ string.substring(index + 1)

removeCurrentWord = (text,cursor_position) ->
	current_word_array = []
	text_array = text.split('')	
	if cursor_position > 0
		spaceOccured = false
		for i in [cursor_position - 1..0]
			if text_array[i] == ' '
				spaceOccured = true
			if spaceOccured
				current_word_array.unshift(text_array[i])
	spaceOccured = false
	for i in [cursor_position..text_array.length]
		if text_array[i] == ' '
			spaceOccured = true
		if spaceOccured
			current_word_array.push(text_array[i])
	current_word_array.join('')
			
$(document).ready ->
	$("input").focus()
	
	$(".dropdown-menu").on "click", "#moreResults", (e)->
		$(".dropdown-menu").empty()
		for arabic_value in results
			$(".dropdown-menu").append("<li><a href='#' class='result'>#{arabic_value}</a></li>");			
		e.stopPropagation();
		
	$(".dropdown-menu").on "click", ".result", ->
		cursor_position = $("input").prop("selectionStart")
		text = $("input").val()
		text = removeCurrentWord(text,cursor_position)	
		text = replaceAt(text,cursor_position, $(this).text())					
		$("input").val(text)
		$("input").focus()

	$("input").focus ->
		if $('.dropdown').hasClass('open')
			$('.dropdown-toggle').dropdown('toggle')
	
	$("input").keyup (e)->
		
		#read current word
		text = $("input").val()
		text_array = text.split('')
		cursor_position = $("input").prop("selectionStart")
		if (e.keyCode == 32) 
			cursor_position = cursor_position - 1
			
		current_word_array = []
				
		if cursor_position > 0
			for i in [cursor_position - 1..0]
				if text_array[i] == ' '
					break
				else
					current_word_array.unshift(text_array[i])
		
		for i in [cursor_position..text_array.length]
			if text_array[i] == ' '
				break
			else
				current_word_array.push(text_array[i])				
		
		current_word = current_word_array.join('')		
	
		#send the word to the transliteration algorithm
		$.ajax
			type: "GET"
			url: "/transliterate"
			dataType: "json"
			data: {original_word:current_word.toLowerCase()}
			
			success: (data) ->
				console.log "Transliteration success"
				console.log data.arabic_values
				results = data.arabic_values
				if (e.keyCode == 32) #space key
					if $('.dropdown').hasClass('open')
						$('.dropdown-toggle').dropdown('toggle')
					if results[0]
						text = removeCurrentWord(text,cursor_position)				
						text = replaceAt(text,cursor_position,results[0])					
						$("input").val(text)
				else if (e.keyCode == 27) #esc key
					if $('.dropdown').hasClass('open')
						$('.dropdown-toggle').dropdown('toggle')
				else if(e.keyCode == 38 || e.keyCode == 40) #up or down keys
					if $(".dropdown-menu a").length != 0
						if !$('.dropdown').hasClass('open')
							$('.dropdown-toggle').dropdown('toggle')			
						$(".dropdown-menu a:first").focus()		
				else
					$(".dropdown-menu").empty()					
					#for arabic_value in results
					#	$(".dropdown-menu").append("<li><a href='#'>#{arabic_value}</a></li>");
					if results.length > 3
						$(".dropdown-menu").append("<li><a href='#' class='result'>#{results[0]}</a></li>");
						$(".dropdown-menu").append("<li><a href='#' class='result'>#{results[1]}</a></li>");
						$(".dropdown-menu").append("<li><a href='#' class='result'>#{results[2]}</a></li>");												
						$(".dropdown-menu").append("<li class='divider'></li><li><a href='#' id='moreResults'><I>More...<I></a></li>");						
					else

						for arabic_value in results
							$(".dropdown-menu").append("<li><a href='#' class='result'>#{arabic_value}</a></li>");
		
					if $(".dropdown-menu a").length != 0
						if !$('.dropdown').hasClass('open')
							$('.dropdown-toggle').dropdown('toggle')
					else
						if $('.dropdown').hasClass('open')
							$('.dropdown-toggle').dropdown('toggle')								
			error:(data) ->
				console.log "Error in transliteration"
				if $('.dropdown').hasClass('open')
					$('.dropdown-toggle').dropdown('toggle')

