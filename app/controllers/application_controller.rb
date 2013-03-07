#!/bin/env ruby
# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def transliterate
    original_word = params[:original_word]
    puts "\n\n\n\n" + original_word
    original_word_array = original_word.split(//)
    puts original_word_array.inspect + "\n\n\n\n"
    array = []
    #@arabic = ""
    original_word_array.each do |character|
      array.unshift(CharacterConvertion.where("latin = '#{character}'").map(&:arabic))
    #  @arabic << CharacterConvertion.find_by_latin(character).arabic
      #this will find the first entry only        
    end
    
    @results = combineAndJoin(array)

    puts @results.inspect
    #puts @arabic
    render :json => {arabic_values: @results}
  end 
  
  def combination(word_array)
    if word_array.count == 1
      puts "here"
      puts word_array[0].inspect
      return word_array[0]
    else
      word0 = word_array.pop()
      puts word0.inspect
      previous_array = combination(word_array)
      new_array = []
          
      
      word0.each do |element2|          
        previous_array.each do |element|        
          sub_array = nil                    
          if element.kind_of?(Array)
            sub_array = element.dup
          else 
            sub_array = []
            sub_array.push(element.dup)          
          end
   #       puts new_array.inspect     
  #        puts element2 + element.inspect     
          new_array.push(sub_array.unshift(element2))
 #         puts "--"
#          puts new_array.inspect                    
        end
      end

      return new_array
    end
  end
  
  def combineAndJoin(array)
    splitted_resluts = combination(array)
    results = []
    splitted_resluts.each do |splitted_word|
      if splitted_word.kind_of?(Array)      
        results.push(splitted_word.join(''))
      else
        results.push(splitted_word)
      end
    end
    return results
  end
  
end
