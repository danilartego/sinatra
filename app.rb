require 'sinatra'
#require 'haml'
require './lib/movie'
require './lib/movie_store'


store = MovieStore.new('movies.yml')

get '/movies' do
  @movies = store.all
  haml :index
end

get '/movies/new' do
  haml :new
end

post '/movies/create' do
  @movie = Movie.new
  @movie.title = params['title']
  @movie.director = params['director']
  @movie.year = params['year']
  @movie.text_area = params['text_area']
  @movie.time = Time.now.strftime("%Y-%m-%d %H:%M:%S")
  store.save(@movie)
  redirect '/movies/new'
end

get '/movies/:id' do
  id = params['id'].to_i
  @movie = store.find(id)
  haml :show
end