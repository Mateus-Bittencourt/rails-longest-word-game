require 'open-uri'


class GamesController < ApplicationController
  def new
    @letters = generate_grid(10).join.gsub(""," ")
    @start_time = Time.now
  end
  def score
    # raise
    @end_time = Time.now
    @word = params[:word]
    @result = run_game(@word, params[:letters].split(' '), Time.parse(params[:start_time]), @end_time)
  end

  def generate_grid(grid_size)
    # TODO: generate random grid of letters
    Array.new(grid_size) { ('A'..'Z').to_a.sample }
  end


  def calc_time_score(time)
    if time > 30
      return 0
    elsif time > 10
      return 10
    else
      return 20
    end
  end

  def load_api(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt.downcase}"
    url_serialized = URI.open(url).read
    JSON.parse(url_serialized)
  end

  def run_game(attempt, grid, start_time, end_time)
    # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)
    json = load_api(attempt)
    esta_no_grid = attempt.upcase.chars.all? { |char| attempt.upcase.count(char) <= grid.count(char) }
    score = 0
    if esta_no_grid
      if json["found"]
        mensagem = "Well done, corret word"
        score = json["length"].to_f + calc_time_score((end_time - start_time).to_f)
      else
        mensagem = "Not an english word"
      end
    else
      mensagem = "Not in the grid"
    end
    { score: score, message: mensagem, time: (end_time - start_time).to_f }
  end
end
