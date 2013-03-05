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
				console.log data.arabic_value
#				possibilities = ["PHP", "MySQL", "SQL", "PostgreSQL", "HTML", "CSS", "HTML5", "CSS3", "JSON"]				
#				possibilities = [data[0].arabic,data[1].arabic]	
#				console.log possibilities
		#		console.log replaceAt(text,1,data.arabic_value)
#				autocomplete = $("input").typeahead()
#				autocomplete.data("typeahead").source = possibilities
				if (e.keyCode == 32) 
#					alert data.arabic_value
					text = removeCurrentWord(text,cursor_position)
#					console.log text					
					text = replaceAt(text,cursor_position,data.arabic_value)					
#					console.log text
					$("input").val(text)
			error:(data) ->
				console.log "Error in transliteration"
				console.log data.arabic_value

