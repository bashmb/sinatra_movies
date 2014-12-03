require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'

helpers do
  def get(url)
    request = RestClient.get(url)
    JSON.parse(request)
  end
end



get '/' do
  erb :index
end

get '/movies' do
  @movies = get("movies.api.mks.io/movies")
  erb :"movies/index"
end

get '/actors' do
  @actors = get("movies.api.mks.io/actors")
  erb :"actors/index"
end

get '/movies/:movieID' do
  @movie_id = params[:movieID]
  @movie_actors = get("movies.api.mks.io/movies/#{@movie_id}/actors")
  @movie_title = get("movies.api.mks.io/movies/#{@movie_id}")
  erb :"movies/show"


  end
get '/actors/:actorID' do
  @actor_id = params[:actorID]
  @actor_name = get("movies.api.mks.io/actors/#{@actor_id}")
  @actor_movies = get("movies.api.mks.io/actors/#{@actor_id}/movies")
  erb :"actors/show"
end

