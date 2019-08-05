require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @answer = params[:answer]

    url = 'https://wagon-dictionary.herokuapp.com'
    word_serialized = open("#{url}/#{@answer}").read
    @score = JSON.parse(word_serialized)
  end
end
