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

  def show
    imdb_id = params[:id]
    response = HTTParty.get("http://www.omdbapi.com/?i=#{imdb_id}&apikey=#{OMDB_API_KEY}")
    @movie = JSON.parse(response.body)
  end
  
end


