require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = generate_grid(10)
  end

  def score
    @grid = params[:grid]
    @attempt = params[:word]
    @word_exist = word_exist?(@attempt)
    @word_in_grid = word_in_grid?(@attempt, @grid)
    @score = recorded_score
  end

  private

  def generate_grid(grid_size)
  # TODO: generate random grid of letters
  grid = []
  grid_size.times do
    letter = ("A".."Z").to_a.sample
    grid << letter
  end
  return grid
  end

  def word_exist?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    attempt_serialised = open(url).read
    attempt_parsed = JSON.parse(attempt_serialised)
    return attempt_parsed["found"]
  end

  def word_in_grid?(attempt, grid)
    attempt.upcase.split('').all? { |char| attempt.upcase.count(char) <= grid.count(char) }
  end

  def recorded_score
    if session[:score].nil?
      session[:score] = 0
    else
      session[:score]
    end
  end
end
