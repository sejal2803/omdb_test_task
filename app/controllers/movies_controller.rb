class MoviesController < ApplicationController
  require 'httparty'
  require 'uri'

  def index
    if params[:search].present?
      search_param = URI.encode_www_form_component(params[:search])
      response = HTTParty.get("http://www.omdbapi.com/?s=#{search_param}&apikey=#{OMDB_API_KEY}")
      @movies = JSON.parse(response.body)["Search"]
    else
      @movies = []
    end
  end
  
  def create
    imdb_id = params[:imdb_id]
    response = HTTParty.get("http://www.omdbapi.com/?i=#{imdb_id}&apikey=#{OMDB_API_KEY}")
    movie_data = JSON.parse(response.body)

    movie = Movie.new(imdb_id: imdb_id)
    movie.save

    # Process movie_data and store relevant information in your Movie model

    redirect_to movie_path(movie)
  end

  def show
    imdb_id = params[:id]
    response = HTTParty.get("http://www.omdbapi.com/?i=#{imdb_id}&apikey=#{OMDB_API_KEY}")
    @movie = JSON.parse(response.body)
  end
  
end


