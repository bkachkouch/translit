#!/bin/env ruby
# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #Transilteration method
  def transliterate
    original_word = params[:original_word]
    #split to transform each character to arabic
    original_word_array = original_word.split(//)
    
    arabic_transformation_array = []

    original_word_array.each do |character|
      arabic_transformation_array.unshift(CharacterConvertion.where("latin = '#{character}'").map(&:arabic))
    end
    
    if arabic_transformation_array.length != 0
      results = combineAndJoin(arabic_transformation_array)
    else
      results = []
    end
    
    #order by frequency desc from database
    @valid_results = ArabicWord.where("word in ('#{results.join('\',\'')}')").order('frequency DESC').map(&:word)
    for result in results
      if !@valid_results.include? result
        @valid_results.push(result)
      end
    end
  
    render :json => {arabic_values: @valid_results}
  end 
  
  #create the different combinations
  def combination(word_array)
    if word_array.count == 1
      return word_array[0]
    else
      word0 = word_array.pop()
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

          new_array.push(sub_array.unshift(element2))        
        end
      end

      return new_array
    end
  end
  
  def combineAndJoin(array)
    splitted_resluts = combination(array)
    results = []
    
    #join distinct words
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
