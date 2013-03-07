# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

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
	
	$(".dropdown-menu").on "click", "a", ->
		cursor_position = $("input").prop("selectionStart")
		text = $("input").val()
		text = removeCurrentWord(text,cursor_position)	
		console.log $(this)
		text = replaceAt(text,cursor_position, $(this).text())					
		$("input").val(text)
		$("input").focus()

	
	$("input").keyup (e)->
		
		#read current word
		text = $("input").val()
		text_array = text.split('')
		console.log text_array
		cursor_position = $("input").prop("selectionStart")
#		console.log cursor_position
		if (e.keyCode == 32) 
			cursor_position = cursor_position - 1
			
		console.log cursor_position
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
		
		
		console.log current_word_array
		current_word = current_word_array.join('')		
	
		#send the word to the transliteration algorithm
		$.ajax
			type: "GET"
			url: "/transliterate"
			dataType: "json"
			data: {original_word:current_word}
			
			success: (data) ->
				console.log "Transliteration success"
				console.log data.arabic_values

				if (e.keyCode == 32) #space key
					if $('.dropdown').hasClass('open')
						$('.dropdown-toggle').dropdown('toggle')
					text = removeCurrentWord(text,cursor_position)				
					text = replaceAt(text,cursor_position,data.arabic_values[0])					
					$("input").val(text)
				else if (e.keyCode == 27) #esc key
					if $('.dropdown').hasClass('open')
						$('.dropdown-toggle').dropdown('toggle')
				else if(e.keyCode == 38 || e.keyCode == 40) #up or down keys
					if !$('.dropdown').hasClass('open')
						$('.dropdown-toggle').dropdown('toggle')			
					$(".dropdown-menu a:first").focus()		
				else
					$(".dropdown-menu").empty()
					for arabic_value in data.arabic_values
						$(".dropdown-menu").append("<li><a href='#'>#{arabic_value}</a></li>");
					if $(".dropdown-menu").length != 0
						if !$('.dropdown').hasClass('open')
							$('.dropdown-toggle').dropdown('toggle')
					else
						if $('.dropdown').hasClass('open')
							$('.dropdown-toggle').dropdown('toggle')								
			error:(data) ->
				console.log "Error in transliteration"
				console.log data.arabic_value

