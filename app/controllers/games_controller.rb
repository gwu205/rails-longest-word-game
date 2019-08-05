require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @answer = params[:answer]
    @letters = params[:letters]

    url = 'https://wagon-dictionary.herokuapp.com'
    word_serialized = open("#{url}/#{@answer}").read
    @score = JSON.parse(word_serialized)

    @word = @score["word"]
    @found = @score["found"]
    @length = @score["length"]
    @match = @answer.upcase.split('').all? do |letter|
      @letters.split.include?(letter)
    end

    if @answer.empty?
      @message = "Please enter a word"
    elsif @match && @found
      @message = "Congrats! Your answer: #{@answer}"
    elsif @match && !@found
      @message = "#{@answer.capitalize} is not a word!"
    elsif !@match && @found
      @message = "Sorry! #{@answer.capitalize} is a word but not in #{@letters}"
    else
      @message = "Try again!"
    end
  end
end
