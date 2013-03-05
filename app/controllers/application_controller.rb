#!/bin/env ruby
# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def transliterate
    original_word = params[:original_word]
    puts "\n\n\n\n" + original_word
    original_word_array = original_word.split(//)
    puts original_word_array.inspect + "\n\n\n\n"
    @arabic = ""
    original_word_array.each do |character|
        @arabic << CharacterConvertion.find_by_latin(character).arabic
        #this will find the first entry only        
    end
    puts @arabic
    render :json => {arabic_value: @arabic}
  end 
  
  def insert
    CharacterConvertion.create({arabic:'آ',latin:'2'})
    CharacterConvertion.create({arabic:'ء',latin:'2'})
    CharacterConvertion.create({arabic:'أ',latin:'2'})
    CharacterConvertion.create({arabic:'ؤ',latin:'2'})
    CharacterConvertion.create({arabic:'إ',latin:'2'})
    CharacterConvertion.create({arabic:'ئ',latin:'2'})
    CharacterConvertion.create({arabic:'ا',latin:'a'})
    CharacterConvertion.create({arabic:'ا',latin:'e'})
    CharacterConvertion.create({arabic:'ا',latin:'é'})
    CharacterConvertion.create({arabic:'ب',latin:'b'})
    CharacterConvertion.create({arabic:'ب',latin:'p'})
    CharacterConvertion.create({arabic:'ت',latin:'t'})
    CharacterConvertion.create({arabic:'ث',latin:'s'})
    CharacterConvertion.create({arabic:'ث',latin:'th'})
    CharacterConvertion.create({arabic:'ج',latin:'g'})
    CharacterConvertion.create({arabic:'ج',latin:'j'})
    CharacterConvertion.create({arabic:'ج',latin:'dj'})
    CharacterConvertion.create({arabic:'ح',latin:'7'})
    CharacterConvertion.create({arabic:'خ',latin:'kh'})
    CharacterConvertion.create({arabic:'خ',latin:'7'''})
    CharacterConvertion.create({arabic:'خ',latin:'5'})
    CharacterConvertion.create({arabic:'د',latin:'d'})
    CharacterConvertion.create({arabic:'ذ',latin:'z'})
    CharacterConvertion.create({arabic:'ذ',latin:'dh'})
    CharacterConvertion.create({arabic:'ذ',latin:'th'})
    CharacterConvertion.create({arabic:'ر',latin:'r'})
    CharacterConvertion.create({arabic:'ز',latin:'z'})
    CharacterConvertion.create({arabic:'س',latin:'s'})
    CharacterConvertion.create({arabic:'ش',latin:'sh'})
    CharacterConvertion.create({arabic:'ش',latin:'ch'})
    CharacterConvertion.create({arabic:'ص',latin:'s'})
    CharacterConvertion.create({arabic:'ص',latin:'9'})
    CharacterConvertion.create({arabic:'ض',latin:'d'})
    CharacterConvertion.create({arabic:'ض',latin:'9'''})
    CharacterConvertion.create({arabic:'ط',latin:'t'})
    CharacterConvertion.create({arabic:'ط',latin:'6'})
    CharacterConvertion.create({arabic:'ظ',latin:'z'})
    CharacterConvertion.create({arabic:'ظ',latin:'dh'})
    CharacterConvertion.create({arabic:'ظ',latin:'t'''})
    CharacterConvertion.create({arabic:'ظ',latin:'6'''})
    CharacterConvertion.create({arabic:'ع',latin:'3'})
    CharacterConvertion.create({arabic:'غ',latin:'gh'})
    CharacterConvertion.create({arabic:'غ',latin:'3'''})
    CharacterConvertion.create({arabic:'ف',latin:'f'})
    CharacterConvertion.create({arabic:'ف',latin:'v'})
    CharacterConvertion.create({arabic:'ق',latin:'2'})
    CharacterConvertion.create({arabic:'ق',latin:'g'})
    CharacterConvertion.create({arabic:'ق',latin:'q'})
    CharacterConvertion.create({arabic:'ق',latin:'8'})
    CharacterConvertion.create({arabic:'ق',latin:'9'})
    CharacterConvertion.create({arabic:'ك',latin:'k'})
    CharacterConvertion.create({arabic:'ك',latin:'g'})
    CharacterConvertion.create({arabic:'ل',latin:'l'})
    CharacterConvertion.create({arabic:'م',latin:'m'})
    CharacterConvertion.create({arabic:'ن',latin:'n'})
    CharacterConvertion.create({arabic:'ه',latin:'h'})
    CharacterConvertion.create({arabic:'ه',latin:'a'})
    CharacterConvertion.create({arabic:'ه',latin:'e'})
    CharacterConvertion.create({arabic:'ه',latin:'ah'})
    CharacterConvertion.create({arabic:'ه',latin:'eh'})
    CharacterConvertion.create({arabic:'ة',latin:'a'})
    CharacterConvertion.create({arabic:'ة',latin:'e'})
    CharacterConvertion.create({arabic:'ة',latin:'ah'})
    CharacterConvertion.create({arabic:'ة',latin:'eh'})
    CharacterConvertion.create({arabic:'و',latin:'w'})
    CharacterConvertion.create({arabic:'و',latin:'o'})
    CharacterConvertion.create({arabic:'و',latin:'u'})
    CharacterConvertion.create({arabic:'و',latin:'ou'})
    CharacterConvertion.create({arabic:'و',latin:'oo'})
    CharacterConvertion.create({arabic:'ي',latin:'y'})
    CharacterConvertion.create({arabic:'ي',latin:'i'})
    CharacterConvertion.create({arabic:'ي',latin:'ee'})
    CharacterConvertion.create({arabic:'ي',latin:'ei'})
    CharacterConvertion.create({arabic:'ي',latin:'ai'})
    CharacterConvertion.create({arabic:'ي',latin:'a'})
    CharacterConvertion.create({arabic:'ى',latin:'y'})
    CharacterConvertion.create({arabic:'ى',latin:'i'})
    CharacterConvertion.create({arabic:'ى',latin:'ee'})
    CharacterConvertion.create({arabic:'ى',latin:'ei'})
    CharacterConvertion.create({arabic:'ى',latin:'ai'})
    CharacterConvertion.create({arabic:'ى',latin:'a'})
  end
end
